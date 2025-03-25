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
    CPU=$(top -bn1 | grep load | awk '{printf "%.2f%%", $(NF-2)}')
    echo "CPU Usage = $CPU"
    echo "Top 5 CPU-consuming processes:"
    ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -6
    echo ""
}

show_mem(){
    MEMORY=$(free -m | awk '/^Mem:/ {
        used=$3; free=$4; total=$2;
        printf "Used: %d MB (%.2f%%), Free: %d MB (%.2f%%)",
        used, used/total*100, free, free/total*100
    }')
    echo "Memory Usage = $MEMORY"
    echo "Top 5 Memory-consuming processes:"
    ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -6
    echo ""
}

show_disk(){
    DISK=$(df -h --total | awk '/total/ {
        size=$2; used=$3; free=$4; percentage=$5;
        printf "Disk Usage = Used: %s (%s), Free: %s, Total: %s", used, percentage, free, size
    }')
    echo "$DISK"
    echo ""
}

main(){
    HOST=$(hostname)
    echo "Server Stats on $HOST"
    echo "=============================="
    show_os
    show_cpu
    show_mem
    show_disk
    echo "Refreshing every 2 seconds... (Press CTRL+C to stop)"
}

while true; do
    clear
    main
    sleep 2
done
