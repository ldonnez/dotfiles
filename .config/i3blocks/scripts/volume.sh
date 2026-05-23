#!/bin/bash

wpctl_out=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
volume_info=$(echo "$wpctl_out" | sed 's/Volume: //; s/\.\([0-9][0-9]\).*/\1/; s/^0//')
mute_status=$(echo "$wpctl_out" | grep -q "MUTED" && echo "yes" || echo "no")

if [ "$mute_status" = "yes" ] || [ "$volume_info" -le 0 ]; then
    icon=""
elif [ "$volume_info" -le 50 ]; then
    icon=""
elif [ "$volume_info" -le 70 ]; then
    icon=""
    color="#e5c890"
else
    icon=""
    color="#ef9f76"
fi

echo "$icon ${volume_info}%"
echo "$icon ${volume_info}%"
echo "$color"
