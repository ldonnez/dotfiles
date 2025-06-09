#!/bin/bash

# Get memory info in kB from /proc/meminfo
mem_total=$(awk '/MemTotal/ {print $2}' /proc/meminfo)
mem_available=$(awk '/MemAvailable/ {print $2}' /proc/meminfo)

# Calculate used memory in kB
mem_used=$((mem_total - mem_available))

# Convert to GB with 1 decimal
used_gb=$(awk "BEGIN { printf \"%.1f\", $mem_used / 1024 / 1024 }")
total_gb=$(awk "BEGIN { printf \"%.1f\", $mem_total / 1024 / 1024 }")

# Calculate usage percentage
usage_percent=$(( 100 * mem_used / mem_total ))

# Output main text and short text
printf "%s/%s GB\n" "$used_gb" "$total_gb"
printf "%s/%s GB\n" "$used_gb" "$total_gb"

# Set color based on usage
if [ "$usage_percent" -ge 90 ]; then
  echo "#e78284"   # red
elif [ "$usage_percent" -ge 70 ]; then
  echo "#e5c890"   # yellow
fi
