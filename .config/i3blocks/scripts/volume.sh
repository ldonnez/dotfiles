#!/bin/bash

# Get volume and mute status from pactl
volume_info=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | head -n1 | tr -d '%')
mute_status=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')

# Set icon based on mute or volume level
if [ "$mute_status" = "yes" ] || [ "$volume_info" -le 0 ]; then
    icon=""  # muted
elif [ "$volume_info" -le 50 ]; then
    icon=""  # low volume
elif [ "$volume_info" -le 70 ]; then
    icon=""  # medium volume
    color="#e5c890"  # yellow
else
    icon=""  # high volume (same icon but different color)
    color="#ef9f76"  # orange
fi

# Output for i3blocks
echo "$icon ${volume_info}%"
echo "$icon ${volume_info}%"
echo "$color"
