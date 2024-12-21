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

function notify_vol {
    # Get the current volume
    vol=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | sed 's/%//')
    # Calculate the volume level for the progress bar
    bar=$(seq -s "." $(($vol / 5)) | sed 's/[0-9]//g')
    # Use swaync to show the volume notification with a progress bar
    swaync -m "Volume: $vol%" -p "[$bar]" -t 1
}

function notify_mute {
    # Get the mute status
    mute=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')
    if [ "$mute" == "yes" ]; then
        # Send a mute notification with swaync
        swaync -m "Muted" -i "/path/to/muted-icon.png" -t 1
    else
        # Send an unmute notification with swaync
        swaync -m "Unmuted" -i "/path/to/unmuted-icon.png" -t 1
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
icodir="~/.config/dunst/icons/vol"

case $1 in
    i) pactl set-sink-volume $nsink +${step}%  # Increase volume
        notify_vol ;;
    d) pactl set-sink-volume $nsink -${step}%  # Decrease volume
        notify_vol ;;
    m) pactl set-sink-mute $nsink toggle  # Toggle mute
        notify_mute ;;
    *) print_error ;;
esac
