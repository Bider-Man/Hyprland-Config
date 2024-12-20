#!/bin/bash

# Get the current volume level
VOLUME=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | head -n 1)

# Send or update the volume notification
notify-send -h int:value:"${VOLUME%?}" -h string:synchronous:volume "Volume" "${VOLUME}"
