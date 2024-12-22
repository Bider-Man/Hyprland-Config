#!/bin/bash

# Get the current volume level
volume=$(pactl list sinks | grep -E '^\s*Volume' | awk '{print $5}' | sed 's/%//')

# Define volume control actions
case $1 in
    up)
        pactl set-sink-volume @DEFAULT_SINK@ +5%
        volume=$((volume + 5))
        if [ "$volume" -gt 100 ]; then volume=100; fi
        ;;
    down)
        pactl set-sink-volume @DEFAULT_SINK@ -5%
        volume=$((volume - 5))
        if [ "$volume" -lt 0 ]; then volume=0; fi
        ;;
    mute)
        pactl set-sink-mute @DEFAULT_SINK@ toggle
        if [ $(pactl list sinks | grep -E '^\s*Mute' | awk '{print $2}') == "yes" ]; then
            volnoti-show -m
            exit 0
        fi
        ;;
    *)
        echo "Invalid option"
        exit 1
        ;;
esac

# Show volume notification using volnoti
volnoti-show $volume