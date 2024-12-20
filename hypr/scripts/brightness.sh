#!/bin/bash

# Get the current brightness level
BRIGHTNESS=$(brightnessctl g)
MAX_BRIGHTNESS=$(brightnessctl m)
PERCENTAGE=$((BRIGHTNESS * 100 / MAX_BRIGHTNESS))

# Send or update the brightness notification
notify-send -h int:value:"$PERCENTAGE" -h string:synchronous:brightness "Brightness" "${PERCENTAGE}%"
