#!/bin/bash

read cpu user nice system idle iowait irq softirq steal guest < /proc/stat
total1=$((user + nice + system + idle + iowait + irq + softirq + steal))
idle1=$((idle + iowait))

sleep 0.5

read cpu user nice system idle iowait irq softirq steal guest < /proc/stat
total2=$((user + nice + system + idle + iowait + irq + softirq + steal))
idle2=$((idle + iowait))

total_diff=$((total2 - total1))
idle_diff=$((idle2 - idle1))
usage=$(( (100 * (total_diff - idle_diff)) / total_diff ))

printf "%02d%%\n" "$usage"

# Line 2 (tooltip)
printf "%02d%%\n" "$usage"

# Color line
if [ "$usage" -ge 90 ]; then
  echo "#e78284"   # red
elif [ "$usage" -ge 80 ]; then
  echo "#e5c890"   # yellow
fi
