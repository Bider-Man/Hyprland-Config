#!/bin/bash

# Get the battery capacity
capacity=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep -i percentage | awk '{print $2}' | sed 's/%//')

# Output the capacity in a format usable by Waybar
echo "{ \"capacity\": \"$capacity\" }"
