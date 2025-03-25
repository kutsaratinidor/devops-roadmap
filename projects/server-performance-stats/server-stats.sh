#!/bin/sh

## Moved the data gathering inside functions so it's updated on every loop
## Used clear at the start of the loop to overwrite the screen
## Removed unnecessary \n — echo already adds newlines

show_os(){
    echo "Sysinfo"
    echo "OS: $(uname -a)"
    echo "Uptime: $(uptime -p)"
    echo "Users: $(who | wc -l)"
    echo ""
}

show_cpu(){
    # Get CPU usage by using idle percentage from top 
    #CPU=$(top -bn1 | grep load | awk '{printf "%.2f%%", $(NF-2)}')
    # $8 is usually the idle percentage.
    CPU=$(top -bn1 | grep "%Cpu" | awk '{printf "%.2f%%", 100 - $8}')
    echo "CPU Usage = $CPU"
    echo "Top 5 CPU-consuming processes:"
    ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -6
    echo ""
}
show_loadavg(){
    # Read the contents of /proc/loadavg, splits it by whitespace, and assigns each part to a variable.
    read one five fifteen < /proc/loadavg
    echo "Load Average = 1min: $one, 5min: $five, 15min: $fifteen"
    echo ""
}
show_mem(){
    # Get mem usage by calculating with total - available then use that for calculating the percentage instead of free
    MEMORY=$(free -m | awk '/^Mem:/ {
        total=$2; used=$3; free=$4; buffers=$6; available=$7;
        real_used = total - available;
        printf "Used: %d MB (%.2f%%), Free: %d MB (%.2f%%)",
        real_used, real_used/total*100, available, available/total*100
    }')
    echo "Memory Usage = $MEMORY"
    echo "Top 5 Memory-consuming processes:"
    ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -6
    echo ""
}

show_disk(){
    # Get Disk usage by using df and getting the prints from the total summary line --total
    DISK=$(df -h --total | awk '/total/ {
        size=$2; used=$3; free=$4; percentage=$5;
        printf "Disk Usage = Used: %s (%s), Free: %s, Total: %s", used, percentage, free, size
    }')
    echo "$DISK"
    echo ""
}

show_failed_logins() {
    logfile="/var/log/auth.log" # or /var/log/secure
    echo "Top failed login sources:"
    grep "Failed password" $logfile | awk '{print $(NF-3)}' | sort | uniq -c | sort -nr | head
}

main(){
    HOST=$(hostname)
    echo "Server Stats on $HOST"
    echo "=============================="
    show_os
    show_failed_logins
    show_cpu
    show_loadavg
    show_mem
    show_disk
    echo "Refreshing every 2 seconds... (Press CTRL+C to stop)"
}

while true; do
    clear
    main
    sleep 2
done
