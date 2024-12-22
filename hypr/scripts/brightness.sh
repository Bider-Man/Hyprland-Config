#!/usr/bin/env bash

# Initialize notification ID
NOTIFY_ID="brightness_notification"

# Get current brightness
get_backlight() {
    brightness=$(brightnessctl -m | cut -d, -f4)
    echo $brightness
}

# Get the brightness icon based on the current value
get_icon() {
    current=$(get_backlight | sed 's/%//')
    if [ "$current" -le "20" ]; then
        icon="🔅"  # Dim brightness symbol
    elif [ "$current" -le "40" ]; then
        icon="🔆"  # Low brightness symbol
    elif [ "$current" -le "60" ]; then
        icon="☀️"  # Medium brightness symbol
    elif [ "$current" -le "80" ]; then
        icon="🌞"  # High brightness symbol
    else
        icon="🌟"  # Maximum brightness symbol
    fi
    echo "$icon"
}

# Send the notification using notify-send
notify_user() {
    current=$(get_backlight)
    icon=$(get_icon)
    notify-send -h int:transient:1 -h string:x-canonical-private-synchronous:"$NOTIFY_ID" \
                -u low -i "dialog-information" "$icon Brightness: $current%"
}

# Change brightness
change_backlight() {
    brightnessctl set "$1" && notify_user
}

# Function to print error if no valid action is provided
print_error() {
    cat << "EOF"
Usage: ./brightness.sh <action>
Valid actions:
    i  Increase brightness (+10%)
    d  Decrease brightness (-10%)
    g  Get current brightness
EOF
}

# Ensure an action is provided
if [ $# -eq 0 ]; then
    print_error
    exit 1
fi

# Set action for brightness adjustment
case $1 in
    i) change_backlight "+10%" ;;  # Increase brightness
    d) change_backlight "10%-" ;;  # Decrease brightness
    g) get_backlight ;;  # Get current brightness
    *) print_error ;;  # Print error for invalid action
esac
