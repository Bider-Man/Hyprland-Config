#!/usr/bin/env sh

# Define functions
function print_error {
cat << "EOF"
    ./volume.sh -[device] <action>
    ...valid device are...
        i -- [i]nput device
        o -- [o]utput device
    ...valid actions are...
        i -- <i>ncrease volume [+5]
        d -- <d>ecrease volume [-5]
        m -- <m>ute [x]
EOF
}

function create_dot_bar {
    vol=$1
    full_dots=$((vol / 10))      # Number of full dots
    half_dots=$(( (vol % 10) >= 5 ? 1 : 0 ))  # 1 if there's a half dot
    empty_dots=$((10 - full_dots - half_dots))

    bar=""

    # Add full dots
    for ((i = 0; i < full_dots; i++)); do
        bar="${bar}●"
    done

    # Add half dot if necessary
    if [ $half_dots -eq 1 ]; then
        bar="${bar}◐"
    fi

    # Add empty dots
    for ((i = 0; i < empty_dots; i++)); do
        bar="${bar}○"
    done

    echo "$bar"
}

function notify_vol {
    # Get the current volume
    vol=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | sed 's/%//')
    # Generate the volume progress bar using dots
    bar=$(create_dot_bar $vol)
    
    # Update the notification with stack tag to prevent stacking
    notify-send -i audio-volume-high "Volume: $vol%" "$bar" -t 2000 -u normal -h string:x-dunst-stack-tag:volume -h string:transient:1
}

function notify_mute {
    # Get the mute status
    mute=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')
    if [ "$mute" == "yes" ]; then
        # Send a mute notification with font-based symbols (replace old notifications with the same stack tag)
        notify-send -i audio-volume-muted "🔇 Muted" -t 2000 -u normal -h string:x-dunst-stack-tag:mute -h string:transient:1
    else
        # Send an unmute notification with font-based symbols (replace old notifications with the same stack tag)
        notify-send -i audio-volume-high "🔊 Unmuted" -t 2000 -u normal -h string:x-dunst-stack-tag:mute -h string:transient:1
    fi
}

# Set device source
while getopts io SetSrc
do
    case $SetSrc in
    i) nsink=$(pactl list short sources | grep "input" | head -n 1 | awk '{print $2}')
       srce="--default-source"
       dvce="mic" ;;
    o) nsink=$(pactl list short sinks | grep "output" | head -n 1 | awk '{print $2}')
       srce=""
       dvce="speaker" ;;
    esac
done

if [ $OPTIND -eq 1 ] ; then
    print_error
fi

# Set device action
shift $((OPTIND -1))
step="${2:-5}"

case $1 in
    i) pactl set-sink-volume $nsink +${step}%  # Increase volume
        notify_vol ;;
    d) pactl set-sink-volume $nsink -${step}%  # Decrease volume
        notify_vol ;;
    m) pactl set-sink-mute $nsink toggle  # Toggle mute
        notify_mute ;;
    *) print_error ;;
esac
