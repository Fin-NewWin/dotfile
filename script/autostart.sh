#!/bin/sh

# Notify
dunst &

# Picom for all display
picom -b

# Set wallpaper
~/script/setwall.sh

# Set keyboard speed
xset r rate 280 40 s off -dpms
