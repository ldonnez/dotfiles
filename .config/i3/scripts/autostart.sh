#!/bin/bash

# set background wallpaper
if [[ -f /usr/local/share/wallpapers/el-capitan-night.jpg ]]; then
  feh --bg-scale /usr/local/share/wallpapers/el-capitan-night.jpg
fi

if [[ ! $(pgrep -u $UID -x cloud-drive-ui) ]]; then
  flatpak run com.synology.SynologyDrive &
fi
