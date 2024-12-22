#!/usr/bin/env bash

# Define notification ID to avoid stacking
NOTIFY_ID="brightness_notification"

# Function to get current brightness
get_backlight() {
    # Get current brightness using brightnessctl and extract the brightness value (percentage)
    brightness=$(brightnessctl g | awk '{print int($1)}')
    echo "$brightness"
}

# Function to determine the icon based on brightness
get_icon() {
    current=$(get_backlight)
    if [ "$current" -le "20" ]; then
        icon="🔅"  # Dim brightness symbol
    elif [ "$current" -le "40" ]; then
        icon="🔆"  # Low brightness symbol
    elif [ "$current" -le "60" ]; then
        icon="☀️"  # Medium brightness symbol
    elif [ "$current" -le "80" ]; then
        icon="🌞"  # High brightness symbol
    else
        icon="🌟"  # Max brightness symbol
    fi
    echo "$icon"
}

# Function to send the notification
notify_user() {
    current=$(get_backlight)
    icon=$(get_icon)
    # Use notify-send with the icon and brightness value
    notify-send -h int:transient:1 -h string:x-canonical-private-synchronous:"$NOTIFY_ID" \
                -u low -i "$icon" "$icon Brightness: $current%"
}

# Function to change brightness
change_backlight() {
    # Pass the argument to brightnessctl to increase/decrease brightness
    brightnessctl set "$1"
    # Call notify_user to show the notification
    notify_user
}

# Check the script's argument and execute accordingly
case "$1" in
    i) change_backlight "+10%" ;;  # Increase brightness by 10%
    d) change_backlight "10%-" ;;  # Decrease brightness by 10%
    g) get_backlight ;;  # Get the current brightness value
    *) echo "Invalid option. Use i, d, or g." ;;  # Handle invalid arguments
esac
