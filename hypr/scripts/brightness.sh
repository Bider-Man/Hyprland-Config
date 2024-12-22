#!/bin/bash

# Notification ID to update the notification instead of stacking
NOTIFY_ID="brightness_notification"

# Function to update the notification
update_brightness_notify() {
    current_brightness=$(brightnessctl g | awk '{print int($1/100*100)}')
    spikes=$((current_brightness / 10))  # Calculate the number of spikes based on brightness level
    spikes_display=$(printf "★%.0s" $(seq 1 $spikes))  # Display stars as "spikes"

    # Send or update the notification with brightness and spikes
    notify-send -r "$NOTIFY_ID" "☀ Brightness: $current_brightness%" "$spikes_display" -u low
}

# Increase brightness
brightness_up() {
    brightnessctl set +10% -m
    update_brightness_notify
}

# Decrease brightness
brightness_down() {
    brightnessctl set -10% -m
    update_brightness_notify
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
