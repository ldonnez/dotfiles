#!/bin/bash

# - To monitor user inactivity on an X11 session using `xprintidle`.
# - To trigger different actions (lock, turn off screen, suspend) at increasing
#   idle durations.
# - To avoid these actions during audio playback, video playback, or fullscreen apps,
#   preserving the user experience (e.g., during movies or games).
#
# USAGE:
# Run as a background service or autostart task in i3 or systemd --user.
# Best used in environments with X11.

LOCK_TIMEOUT=$((5 * 60 * 1000))        # 5 minutes
SCREEN_OFF_TIMEOUT=$((10 * 60 * 1000)) # 10 minutes
SUSPEND_TIMEOUT=$((20 * 60 * 1000))    # 20 minutes

while true; do

  IDLE=$(xprintidle)
  IDLE_IN_SECONDS=$((IDLE / 1000))

  # Skip if audio is playing
  if pactl list sink-inputs | grep -q 'Sink Input'; then
   echo "Audio is playing, skipping."
   sleep 30
   continue
  fi

  # Skip if video is playing
  if playerctl status 2>/dev/null | grep -q Playing; then
    echo "Video is playing, skipping."
    sleep 30
    continue
  fi

  # Check for full-screen window
  ACTIVE_WIN=$(xprop -root _NET_ACTIVE_WINDOW | awk -F'# ' '{print $2}')
  if [ -n "$ACTIVE_WIN" ]; then
    if xprop -id "$ACTIVE_WIN" _NET_WM_STATE | grep -q '_NET_WM_STATE_FULLSCREEN'; then
      echo "Fullscreen app is active, skipping"
      sleep 30
      continue
    fi
  fi

  if [ "$IDLE" -ge "$SUSPEND_TIMEOUT" ]; then
    echo "Idle for $IDLE_IN_SECONDS seconds. Suspending."
    systemctl suspend
  elif [ "$IDLE" -ge "$SCREEN_OFF_TIMEOUT" ]; then
    echo "Idle for $IDLE_IN_SECONDS seconds. Turning off screen."
    xset dpms force off
  elif [ "$IDLE" -ge "$LOCK_TIMEOUT" ]; then
    if pgrep -x i3lock >/dev/null; then
      echo "Already locked. Skipping lock."
    else
      echo "Idle for $IDLE_IN_SECONDS seconds. Locking session."
      $HOME/.config/i3/scripts/lock.sh
    fi
  fi

  sleep 30
done
