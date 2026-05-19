#!/bin/bash

# Define your monitor you can get it by typing hyprctl monitor
MONITOR="HDMI-A-2"


CURRENT_RATE=$(hyprctl monitors | grep "$MONITOR" | grep -o '[0-9.]*Hz' | sed 's/Hz//')


# Define your two refresh rates you want to toggle between
RATE1="60"
RATE2="48"


if [ "$(echo $CURRENT_RATE | bc)" == "$(echo $RATE1 | bc)" ]; then
  hyprctl keyword monitor $MONITOR,3840x2160@$RATE2,auto,2.5,bitdepth,10
  notify-send "48Hz" "mode" --icon=display
else
  hyprctl keyword monitor $MONITOR,3840x2160@$RATE1,auto,2.5,bitdepth,10
  notify-send "60Hz" "mode" --icon=display
fi