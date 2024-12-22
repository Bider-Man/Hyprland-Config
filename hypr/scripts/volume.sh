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
    # Calculate the number of dots for the progress bar
    bar_length=20  # Total length of the progress bar (number of characters)
    filled=$(($vol * $bar_length / 100))  # Calculate how many dots to fill
    bar=$(printf "%${filled}s" | tr ' ' '.')
    
    # Ensure the progress bar is filled to the correct length (20 characters)
    bar=$(printf "%-${bar_length}s" "$bar")
    
    # Use font-based symbols for the notification
    if [ "$vol" -ge 66 ]; then
        icon="🔊"  
    elif [ "$vol" -ge 33 ]; then
        icon="🔉"  
    else
        icon="🔈"  
    fi

    # Send the notification using notify-send
    notify-send -h int:transient:1 -h string:x-canonical-private-synchronous:"$NOTIFY_ID" \
                "$icon Volume: $vol%" "$bar"
}

function notify_mute {
    mute=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')
    if [ "$mute" == "yes" ]; then
        notify-send -h int:transient:1 -h string:x-canonical-private-synchronous:"$NOTIFY_ID" \
                    "🔇 Muted"
    else
        notify-send -h int:transient:1 -h string:x-canonical-private-synchronous:"$NOTIFY_ID" \
                    "🔊 Unmuted"
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
