#!/bin/bash

# Get the current volume percentage
volume=$(pactl list sinks | grep -E '^\s*Volume' | awk '{print $5}' | sed 's/%//')

# Check if muted
muted=$(pactl list sinks | grep -E '^\s*Mute' | awk '{print $2}')

# Show notification with volnoti
if [ "$muted" == "yes" ]; then
    volnoti-show -m
else
    volnoti-show $volume
fi
