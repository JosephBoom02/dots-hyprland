#!/usr/bin/env bash

# 1. Trigger Quickshell lock 
hyprctl dispatch global quickshell:lock

# 2. Start hyprlock if it isn't already running
if ! pidof hyprlock > /dev/null; then
    hyprlock &
    
    # CRITICAL: Wait for hyprlock to fully initialize and grab the screen.
    # If your PC is older/slower, you might need to increase this to 1.5 or 2.
    sleep 1
fi

# 3. Suspend the system safely
systemctl suspend