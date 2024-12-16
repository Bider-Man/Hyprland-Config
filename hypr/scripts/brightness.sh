#!/bin/bash

# Notify when brightness is increased
brightness_up() {
    current_brightness=$(brightnessctl g | awk '{print int($1/100*100)}')
    notify-send "Brightness Up" "Current brightness: $current_brightness%" -i display-brightness-high
}

# Notify when brightness is decreased
brightness_down() {
    current_brightness=$(brightnessctl g | awk '{print int($1/100*100)}')
    notify-send "Brightness Down" "Current brightness: $current_brightness%" -i display-brightness-low
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
