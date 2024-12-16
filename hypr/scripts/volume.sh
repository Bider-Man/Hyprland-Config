#!/bin/bash

# Notify when the volume is increased
volume_up() {
    current_volume=$(amixer get Master | grep -oP '\d+%' | head -n 1)
    notify-send "Volume Up" "Current volume: $current_volume" -i audio-volume-high
}

# Notify when the volume is decreased
volume_down() {
    current_volume=$(amixer get Master | grep -oP '\d+%' | head -n 1)
    notify-send "Volume Down" "Current volume: $current_volume" -i audio-volume-low
}

# Notify when the volume is muted
volume_mute() {
    current_mute_status=$(amixer get Master | grep -oP '\[.*\]' | head -n 1)
    if [[ $current_mute_status == "[off]" ]]; then
        notify-send "Volume Muted" -i audio-volume-muted
    else
        notify-send "Volume Unmuted" -i audio-volume-high
    fi
}

# Detect the type of volume action
case "$1" in
    "volume-up")
        volume_up
        ;;
    "volume-down")
        volume_down
        ;;
    "volume-mute")
        volume_mute
        ;;
    *)
        echo "Invalid argument. Use 'volume-up', 'volume-down', or 'volume-mute'."
        ;;
esac
