#!/bin/bash

# Lock screen script using i3lock-color (https://github.com/Raymo111/i3lock-color).
#
# This script displays a lock screen with a blurred background,
# current date, and time. It is used in:
# - ~/.config/i3/config
# - ~/.config/i3/scripts/idle-check.sh

BLANK='#00000000'
CLEAR='#ffffff22'
DEFAULT='#babbf1'
TEXT='#c6d0f5'
KEYPRESS='#a6d189'
WRONG='#ea999c'
VERIFYING='#8caaee'

i3lock \
--insidever-color=$CLEAR     \
--ringver-color=$VERIFYING   \
\
--insidewrong-color=$CLEAR   \
--ringwrong-color=$WRONG     \
\
--inside-color=$BLANK        \
--ring-color=$DEFAULT        \
--line-color=$BLANK          \
--separator-color=$DEFAULT   \
\
--verif-color=$TEXT          \
--wrong-color=$TEXT          \
--time-color=$TEXT           \
--date-color=$TEXT           \
--layout-color=$TEXT         \
--keyhl-color=$KEYPRESS      \
--bshl-color=$WRONG          \
\
--screen 1                   \
--blur  15                   \
--clock                      \
--indicator                  \
--time-str="%H:%M:%S"        \
--date-str="%A, %Y-%m-%d"    \
