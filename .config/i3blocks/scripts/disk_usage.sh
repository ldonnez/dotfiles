#!/bin/bash

# Target disk mount point
disk="/"

# Get used and total space in GB (rounded)
used=$(df -BG "$disk" | awk 'NR==2 {print $3}' | sed 's/G//')
total=$(df -BG "$disk" | awk 'NR==2 {print $2}' | sed 's/G//')

# Format output with icon and zero-padded used and total
printf "%d/%d GB\n" "$used" "$total"
printf "%d/%d GB\n" "$used" "$total"

# Optional color based on usage percentage
usage_percent=$(df "$disk" | awk 'NR==2 {print $5}' | sed 's/%//')

if [ "$usage_percent" -ge 90 ]; then
  echo "#e78284"   # red
elif [ "$usage_percent" -ge 70 ]; then
  echo "#e5c890"   # yellow
fi
