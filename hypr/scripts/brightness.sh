#!/bin/bash

# Function to generate the spike pattern
generate_spikes() {
    # Get the current brightness as an integer percentage
    brightness=$1
    # Calculate the number of spikes based on the brightness (10 spikes max for 100%)
    num_spikes=$((brightness / 10))
    # Generate a string of spikes based on the current brightness
    spikes=""
    for ((i = 1; i <= num_spikes; i++)); do
        spikes+="★"
    done
    # Return the generated spike pattern
    echo "$spikes"
}

# Notify when brightness is increased
brightness_up() {
    current_brightness=$(brightnessctl g | awk '{print int($1/100*100)}')
    spikes=$(generate_spikes $current_brightness)
    notify-send "Brightness Up" "Current brightness: $current_brightness% $spikes" -i display-brightness-high
}

# Notify when brightness is decreased
brightness_down() {
    current_brightness=$(brightnessctl g | awk '{print int($1/100*100)}')
    spikes=$(generate_spikes $current_brightness)
    notify-send "Brightness Down" "Current brightness: $current_brightness% $spikes" -i display-brightness-low
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
