#!/bin/bash

# server-stats.sh - Basic Linux server performance statistics

echo "========== SERVER PERFORMANCE STATS =========="

# Total CPU Usage
echo ""
echo "CPU USAGE:"
CPU_USAGE=$(top -bn1 | grep "%Cpu(s)" | awk '{print 100 - $8 "%"}')
echo "Total CPU Usage: $CPU_USAGE"

# Total Memory Usage
echo ""
echo "MEMORY USAGE:"
MEMORY=$(free -m)
TOTAL_MEM=$(echo "$MEMORY" | awk '/Mem:/ {print $2}')
USED_MEM=$(echo "$MEMORY" | awk '/Mem:/ {print $3}')
FREE_MEM=$(echo "$MEMORY" | awk '/Mem:/ {print $4}')
PERCENT_MEM=$(awk "BEGIN {printf \"%.2f\", ($USED_MEM/$TOTAL_MEM)*100}")
echo "Total: ${TOTAL_MEM}MB"
echo "Used : ${USED_MEM}MB"
echo "Free : ${FREE_MEM}MB"
echo "Usage: $PERCENT_MEM%"

# Total Disk Usage
echo ""
echo "DISK USAGE:"
DISK_USAGE=$(df -h --total | grep total)
USED_DISK=$(echo "$DISK_USAGE" | awk '{print $3}')
FREE_DISK=$(echo "$DISK_USAGE" | awk '{print $4}')
PERCENT_DISK=$(echo "$DISK_USAGE" | awk '{print $5}')
echo "Used : $USED_DISK"
echo "Free : $FREE_DISK"
echo "Usage: $PERCENT_DISK"

# Top 5 Processes by CPU usage
echo ""
echo "TOP 5 PROCESSES BY CPU USAGE:"
ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -n 6 | awk '{printf "%-6s %-20s %-6s %-6s\n", $1, $2, $3"%", $4"%"}'

# Top 5 Processes by Memory usage
echo ""
echo "TOP 5 PROCESSES BY MEMORY USAGE:"
ps -eo pid,comm,%cpu,%mem --sort=-%mem | head -n 6 | awk '{printf "%-6s %-20s %-6s %-6s\n", $1, $2, $3"%", $4"%"}'

# Uptime
echo ""
echo "UPTIME:"
uptime -p
echo "Last boot: $(uptime -s)"

echo ""
echo "==============================================="
