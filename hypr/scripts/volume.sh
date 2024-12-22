#!/usr/bin/env sh

# Define notification ID for volume notifications
NOTIFY_ID="volume_notification"

# Print error message for incorrect usage
function print_error {
cat << "EOF"
Usage: ./volume.sh -[device] <action>
Valid devices are:
    i -- Input device
    o -- Output device
Valid actions are:
    i -- Increase volume [+5]
    d -- Decrease volume [-5]
    m -- Mute/unmute
EOF
}

# Function to send volume notification
function notify_vol {
    # Get the current volume percentage
    vol=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | sed 's/%//')
    
    # Create a volume bar with dots
    full_dots=$((vol / 10))
    half_dot=$((vol % 10 >= 5 ? 1 : 0))
    bar=$(printf '●%.0s' $(seq 1 $full_dots))$( [ "$half_dot" -eq 1 ] && echo "◐" || echo "")$(printf '○%.0s' $(seq 1 $((10 - full_dots - half_dot))))
    
    # Choose an icon based on volume level
    if [ "$vol" -ge 66 ]; then
        icon="🔊"  # High volume
    elif [ "$vol" -ge 33 ]; then
        icon="🔉"  # Medium volume
    else
        icon="🔈"  # Low volume
    fi

    # Update the volume notification
    swaync client --id "$NOTIFY_ID" --content "$icon Volume: $vol% [$bar]" --timeout 2000
}

# Function to send mute notification
function notify_mute {
    mute=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')
    if [ "$mute" == "yes" ]; then
        swaync client --id "$NOTIFY_ID" --content "🔇 Muted" --timeout 2000
    else
        swaync client --id "$NOTIFY_ID" --content "🔊 Unmuted" --timeout 2000
    fi
}

# Determine the device (input/output) from arguments
while getopts io SetSrc
do
    case $SetSrc in
    i) nsink=$(pactl list short sources | grep "input" | head -n 1 | awk '{print $2}')
       ;;
    o) nsink=$(pactl list short sinks | grep "output" | head -n 1 | awk '{print $2}')
       ;;
    esac
done

if [ $OPTIND -eq 1 ]; then
    print_error
    exit 1
fi

# Shift positional arguments and get action
shift $((OPTIND - 1))
step="${2:-5}"

# Perform the selected action
case $1 in
    i) pactl set-sink-volume "$nsink" +${step}%  # Increase volume
        notify_vol ;;
    d) pactl set-sink-volume "$nsink" -${step}%  # Decrease volume
        notify_vol ;;
    m) pactl set-sink-mute "$nsink" toggle  # Toggle mute
        notify_mute ;;
    *) print_error ;;
esac
