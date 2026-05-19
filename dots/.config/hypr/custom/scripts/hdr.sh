#!/bin/bash

# Get first monitor's info
MONITOR=$(hyprctl monitors -j | python3 -c "
import json, sys
m = json.load(sys.stdin)[0]
name = m['name']
w, h = m['width'], m['height']
rr = m['refreshRate']
x, y = m['x'], m['y']
scale = m['scale']
print(f'{name},{w}x{h}@{rr},{x}x{y},{scale}')
")

STATE_FILE="/tmp/hypr-hdr-state"

if [ -f "$STATE_FILE" ]; then
    # HDR is on — turn it off by reloading config
    rm "$STATE_FILE"
    hyprctl reload
    notify-send "HDR" "Disabled"
else
    # HDR is off — turn it on at runtime
    touch "$STATE_FILE"
    NAME=$(echo "$MONITOR" | cut -d',' -f1)
    REST=$(echo "$MONITOR" | cut -d',' -f2-)
    hyprctl keyword monitor "$NAME,$REST,bitdepth,10,cm,hdr"
    notify-send "HDR" "Enabled"
fi