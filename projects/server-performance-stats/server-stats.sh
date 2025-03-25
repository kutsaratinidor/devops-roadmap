#!/bin/sh

HOST=$(hostname)
CPU=$(top -bn1 | grep load | awk '{printf "%.2f%%\t\t\n", $(NF-2)}')
MEMORY=$(free -m | awk '/^Mem:/ {used=$3; free=$4; total=$2; printf "Used: %d MB (%.2f%%), Free: %d MB (%.2f%%)\n", used, used/total*100, free, free/total*100}')
DISK=$(df -h --total | awk '/total/ { size=$2; used=$3; free=$4; percentage=$5; printf "Disk Usage = Used: %d GB (%.2f%%), Free: %d GB (%.2f%%), Total: %d GB \n", used, percentage, free, free/size*100, size}')


show_os(){

}

show_cpu(){
    echo "CPU Usage = $CPU\n"
    echo "CPU Usage top 5\n" 
    ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -6
}
show_mem(){
    echo "Memory Usage = $MEMORY\n"
    echo "Memory Usage top5 \n"
    ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -6
}

show_disk(){
    echo "Disk Usage   = $DISK\n"
}
main(){
    echo "Server Stats on $HOST\n"
    show_os()
    show_cpu()
    show_mem()
    show_disk()

}