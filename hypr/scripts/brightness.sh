#!/usr/bin/env sh

# Define functions
function print_error {
cat << "EOF"
    ./brightness.sh -[device] <action>
    ...valid device are...
        b -- [b]rightness device
    ...valid actions are...
        i -- <i>ncrease brightness [+10]
        d -- <d>ecrease brightness [-10]
EOF
}

# Initialize notification ID
NOTIFY_ID="brightness_notification"

function notify_brightness {
    brightness=$(brightnessctl g | awk '{print int($1/100*100)}')  # Get brightness in percentage
    bar=$(seq -s "." $(($brightness / 10)) | sed 's/[0-9]//g')  # Build the progress bar with dots
    
    # Use font-based symbols for brightness
    if [ "$brightness" -ge 66 ]; then
        icon="☀️"  # Full brightness
    elif [ "$brightness" -ge 33 ]; then
        icon="🌞"  # Medium brightness
    else
        icon="🌑"  # Low brightness
    fi

    # Send the notification using notify-send
    notify-send -h int:transient:1 -h string:x-canonical-private-synchronous:"$NOTIFY_ID" \
                "$icon Brightness: $brightness%" "$bar"
}

# Set device source
while getopts b SetSrc
do
    case $SetSrc in
    b) nsink="brightnessctl"  # Use brightnessctl for brightness control
       srce=""
       dvce="brightness" ;;
    esac
done

if [ $OPTIND -eq 1 ] ; then
    print_error
fi

# Set device action
shift $((OPTIND -1))
step="${2:-10}"

case $1 in
    i) brightnessctl set +${step}%  
        notify_brightness ;;
    d) brightnessctl set -${step}%  
        notify_brightness ;;
    *) print_error ;;
esac
