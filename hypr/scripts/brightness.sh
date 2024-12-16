#!/bin/bash
brightness=$(brightnessctl get)
max_brightness=$(brightnessctl max)
percentage=$((100 * brightness / max_brightness))
dunstify -u low -r 9998 -h int:value:$percentage "Brightness" "$percentage%"
