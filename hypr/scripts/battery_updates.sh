#!/bin/bash

# Get the current battery percentage
battery_percentage=$(cat /sys/class/power_supply/BAT0/capacity)

# Set the size of the circle and font for percentage
size=100
font_size=20

# Create an image with a circle and the percentage inside
convert -size ${size}x${size} xc:white \
  -draw "fill blue circle $((size / 2)),$((size / 2)) $((size / 2)),$((size / 2 - 10))" \
  -font DejaVu-Sans -pointsize $font_size \
  -draw "text $((size / 3)),$((size / 2 + font_size / 3)) '$battery_percentage%'" \
  -background transparent -trim \
  /tmp/battery-icon.png

# Output the image file
echo "/tmp/battery-icon.png"
