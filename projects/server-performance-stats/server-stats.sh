#!/bin/sh

HOST=$(hostname)
CPU=$(top -bn1 | grep load | awk '{printf "%.2f%%\t\t\n", $(NF-2)}')
MEMORY=$(free -m | awk '/^Mem:/ {used=$3; free=$4; total=$2; printf "Used: %d MB (%.2f%%), Free: %d MB (%.2f%%)\n", used, used/total*100, free, free/total*100}')
DISK=$(df -h --total | awk '/total/ { size=$2; used=$3; free=$4; percentage=$5; printf "Disk Usage = Used: %d GB (%.2f%%), Free: %d GB (%.2f%%), Total: %d GB \n", used, percentage, free, free/size*100, size}')

echo "Server Stats on $HOST\n"
echo "CPU Usage    = $CPU\n"
echo "Memory Usage = $MEMORY\n"
echo "Disk Usage   = $DISK\n"

