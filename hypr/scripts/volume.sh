#!/bin/bash

# Get the current volume
VOLUME=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | head -n 1 | tr -d '%')

# Cap the volume at 100%
DISPLAY_VOLUME=$((VOLUME > 100 ? 100 : VOLUME))

# Output the capped volume
echo -n "${DISPLAY_VOLUME}%"
