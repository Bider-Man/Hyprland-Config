#!/usr/bin/env sh

# Default settings
nsink=$(pactl get-default-sink)
step=5  # Volume step (increase/decrease by 5%)
icodir="~/.config/dunst/icons/vol"
font="Monospace 12"  # Font for the notification text

# Function to display volume notifications
function notify_vol {
    vol=$(pactl get-sink-volume $nsink | awk '{print $5}' | sed 's/%//g')  # Get volume percentage
    progress=$((vol / 10))  # Calculate progress (divide by 10 for 10 levels)

    # Create a progress bar string
    bar=$(seq -s "█" $progress | sed 's/[0-9]//g')  # 10 levels of █ for the progress bar
    empty_bar=$(seq -s "░" $((10 - progress)) | sed 's/[0-9]//g')  # Remaining empty space

    # Combine progress bar
    full_bar="$bar$empty_bar"
    
    # Send notification using notify-send
    notify-send -u low "Volume" "$vol% $full_bar" -i audio-volume-high -t 2000 -f "$font"
}

# Function to display mute/unmute notifications
function notify_mute {
    mute=$(pactl get-sink-mute $nsink | awk '{print $2}')  # Get mute status
    if [ "$mute" == "yes" ]; then
        # Send muted notification
        notify-send -u low "Muted" "Mute is ON" -i audio-volume-muted -t 2000 -f "$font"
    else
        # Send unmuted notification
        notify-send -u low "Unmuted" "Mute is OFF" -i audio-volume-high -t 2000 -f "$font"
    fi
}

# Handle the volume and mute actions
case $1 in
    i)  # Increase volume
        pactl set-sink-volume $nsink +${step}%  # Increase volume by $step
        notify_vol  # Update volume notification
        ;;
    d)  # Decrease volume
        pactl set-sink-volume $nsink -${step}%  # Decrease volume by $step
        notify_vol  # Update volume notification
        ;;
    m)  # Toggle mute/unmute
        pactl set-sink-mute $nsink toggle  # Toggle mute
        notify_mute  # Update mute/unmute notification
        ;;
    *)  # Invalid action
        echo "Usage: $0 {i|d|m}"
        ;;
esac
