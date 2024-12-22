#!/usr/bin/env bash

# Set icon directory
iDIR="$HOME/.config/hypr/mako/icons"

# Initialize notification ID
NOTIFY_ID="brightness_notification"

# Get current brightness
get_backlight() {
    echo $(brightnessctl -m | cut -d, -f4)
}

# Get the corresponding icon based on brightness
get_icon() {
    current=$(get_backlight | sed 's/%//')
    if [ "$current" -le "20" ]; then
        icon="$iDIR/brightness-20.png"
    elif [ "$current" -le "40" ]; then
        icon="$iDIR/brightness-40.png"
    elif [ "$current" -le "60" ]; then
        icon="$iDIR/brightness-60.png"
    elif [ "$current" -le "80" ]; then
        icon="$iDIR/brightness-80.png"
    else
        icon="$iDIR/brightness-100.png"
    fi
}

# Send the notification
notify_user() {
    current=$(get_backlight)
    notify-send -h int:transient:1 -h string:x-canonical-private-synchronous:"$NOTIFY_ID" \
                -u low -i "$icon" "Brightness : $current%"
}

# Change brightness
change_backlight() {
    brightnessctl set "$1" && get_icon && notify_user
}

# Function to print error if no valid action is provided
print_error() {
    cat << "EOF"
    ./brightness.sh -[device] <action>
    ...valid actions are...
        i -- <i>ncrease brightness [+10]
        d -- <d>ecrease brightness [-10]
        g -- <g>et current brightness
EOF
}

# Set device action
while getopts "b" SetSrc
do
    case $SetSrc in
    b) nsink="brightnessctl" ;;
    esac
done

# If no option provided, print error
if [ $OPTIND -eq 1 ] ; then
    print_error
    exit 1
fi

# Set action for brightness adjustment
shift $((OPTIND -1))
step="${2:-10}"

case $1 in
    i) change_backlight "+${step}%" ;;
    d) change_backlight "${step}%-" ;;
    g) get_backlight ;;
    *) print_error ;;
esac
