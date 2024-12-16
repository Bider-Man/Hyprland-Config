#!/bin/bash
volume=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d+(?=%)' | head -n 1)
dunstify -u low -r 9999 -h int:value:$volume "Volume" "$volume%"
