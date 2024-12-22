#!/bin/bash

# Get volume percentage
volume=$(pactl list sinks | grep -E '^\s*Volume' | awk '{print $5}' | sed 's/%//')

# Determine action (increase, decrease, mute)
case $1 in
    up) pactl set-sink-volume @DEFAULT_SINK@ +5% ;;
    down) pactl set-sink-volume @DEFAULT_SINK@ -5% ;;
    mute) pactl set-sink-mute @DEFAULT_SINK@ toggle ;;
esac

# Show notification with volnoti
volnoti-show $volume
