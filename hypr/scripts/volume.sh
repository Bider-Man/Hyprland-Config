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
    bar=$(seq -s "." $(($vol / 5)) | sed 's/[0-9]//g')
    
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

case $1 in
    i) pactl set-sink-volume $nsink +${step}%  
        notify_vol ;;
    d) pactl set-sink-volume $nsink -${step}%  
        notify_vol ;;
    m) pactl set-sink-mute $nsink toggle  
        notify_mute ;;
    *) print_error ;;
esac
