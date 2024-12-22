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

# Initialize notification ID
NOTIFY_ID="volume_notification"

function notify_vol {
    vol=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | sed 's/%//')

    # Calculate the number of full circles and half circles for the progress bar
    full_circles=$((vol / 10))
    half_circles=$(((vol % 10) / 5))

    # Build the progress bar
    bar=""
    for ((i=0; i<full_circles; i++)); do
        bar+="⚪"  # Filled circle for every 10%
    done

    if [ "$half_circles" -gt 0 ]; then
        bar+="◌"  # Half circle for 5%
    fi

    # Fill remaining space with empty circles
    remaining=$((10 - full_circles - half_circles))
    for ((i=0; i<remaining; i++)); do
        bar+="◯"  # Unfilled circle for remaining part
    done

    # Adjust the length of the progress bar to fit the notification width
    total_length=10
    progress_length=${#bar}
    remaining_length=$((total_length - progress_length))

    # Add empty circles to the right to fill the remaining space
    for ((i=0; i<remaining_length; i++)); do
        bar+="◯"
    done

    # Use different icons based on the volume level
    if [ "$vol" -ge 66 ]; then
        icon="🔊"  
    elif [ "$vol" -ge 33 ]; then
        icon="🔉"  
    else
        icon="🔈"  
    fi

    # Send the notification with volnoti
    volnoti -s "$vol%" -p "$icon" -m "$bar"
}

function notify_mute {
    mute=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')
    if [ "$mute" == "yes" ]; then
        volnoti -s "Muted" -p "🔇" -m "Volume is muted"
    else
        volnoti -s "Unmuted" -p "🔊" -m "Volume is unmuted"
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

# Get current volume
current_vol=$(pactl get-sink-volume $nsink | awk '{print $5}' | sed 's/%//')

# Ensure volume doesn't exceed 100%
if [ "$1" == "i" ]; then
    if [ $(($current_vol + $step)) -le 100 ]; then
        pactl set-sink-volume $nsink +${step}%
    else
        pactl set-sink-volume $nsink 100%
    fi
    notify_vol
elif [ "$1" == "d" ]; then
    pactl set-sink-volume $nsink -${step}%
    notify_vol
elif [ "$1" == "m" ]; then
    pactl set-sink-mute $nsink toggle
    notify_mute
else
    print_error
fi
