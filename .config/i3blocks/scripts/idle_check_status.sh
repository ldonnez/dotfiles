#!/bin/bash

# Left-click: toggle the service
if [ "$BLOCK_BUTTON" == "1" ]; then
    status=$(systemctl --user is-active idle-check.service 2>/dev/null)
    if [ "$status" = "active" ]; then
        systemctl --user stop idle-check.service
    else
        systemctl --user start idle-check.service
    fi
fi

# Check service status using systemctl
status=$(systemctl --user is-active idle-check.service 2>/dev/null)

if [ "$status" = "active" ]; then
    echo " on"
    echo "running"
elif [ "$status" = "inactive" ]; then
    echo " off"
    echo "stopped"
    echo "#e5c890"  # yellow
else
    echo " unknown"
    echo "unknown"
fi
