#!/bin/bash

# Notification ID to update the notification instead of stacking
NOTIFY_ID="brightness_notification"

# Function to update the notification
notify_brightness() {
    current_brightness=$(brightnessctl g | awk '{print int($1/100*100)}')
    bar=$(seq -s "." $(($current_brightness / 10)) | sed 's/[0-9]//g')  # Build the progress bar with dots

    # Use font-based symbol for brightness icon
    if [ "$current_brightness" -ge 66 ]; then
        icon="☀"  # Full brightness
    elif [ "$current_brightness" -ge 33 ]; then
        icon="🌞"  # Medium brightness
    else
        icon="🌑"  # Low brightness
    fi

    # Send or update the notification with brightness percentage and bar
    notify-send -r "$NOTIFY_ID" "$icon Brightness: $current_brightness%" "[$bar]" -u low
}

# Increase brightness
brightness_up() {
    brightnessctl set +10% -m
    notify_brightness
}

# Decrease brightness
brightness_down() {
    brightnessctl set -10% -m
    notify_brightness
}

# Detect the type of brightness action
case "$1" in
    "brightness-up")
        brightness_up
        ;;
    "brightness-down")
        brightness_down
        ;;
    *)
        echo "Invalid argument. Use 'brightness-up' or 'brightness-down'."
        ;;
esac
