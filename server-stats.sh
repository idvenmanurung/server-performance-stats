#!/bin/bash

echo "===== Server Performance Stats ====="
echo ""

# CPU Usage
echo "[CPU USAGE]"
top -bn1 | grep "Cpu(s)" | awk '{print "CPU Usage: " 100 - $8 "%"}'
echo ""

# Memory Usage
echo "[MEMORY USAGE]"
free -h | awk '/Mem:/ {printf("Used: %s / Total: %s (%.2f%%)\n", $3, $2, $3/$2 * 100)}'
echo ""

# Disk Usage
echo "[DISK USAGE]"
df -h / | awk 'NR==2 {print "Used: " $3 " / Total: " $2 " (" $5 " used)"}'
echo ""

# Top 5 CPU-consuming processes
echo "[TOP 5 CPU PROCESSES]"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6
echo ""

# Top 5 Memory-consuming processes
echo "[TOP 5 MEMORY PROCESSES]"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6
echo ""

# Optional Stretch Goals
echo "[SYSTEM INFO]"
echo "OS Version: $(lsb_release -d | cut -f2)"
echo "Uptime: $(uptime -p)"
echo "Load Average: $(uptime | awk -F'load average:' '{ print $2 }')"
echo "Logged In Users:"
who
echo ""

