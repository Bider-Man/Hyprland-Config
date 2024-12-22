#!/usr/bin/env bash

# Function to change wallpaper using swww
switch() {
	imgpath=$1
	read scale screenx screeny screensizey < <(hyprctl monitors -j | jq '.[] | select(.focused) | .scale, .x, .y, .height' | xargs)
	cursorposx=$(hyprctl cursorpos -j | jq '.x' 2>/dev/null) || cursorposx=960
	cursorposx=$(bc <<< "scale=0; ($cursorposx - $screenx) * $scale / 1")
	cursorposy=$(hyprctl cursorpos -j | jq '.y' 2>/dev/null) || cursorposy=540
	cursorposy=$(bc <<< "scale=0; ($cursorposy - $screeny) * $scale / 1")
	cursorposy_inverted=$((screensizey - cursorposy))

	if [ "$imgpath" == '' ]; then
		echo 'Aborted'
		exit 0
	fi

	swww img "$imgpath" --transition-step 100 --transition-fps 120 \
		--transition-type grow --transition-angle 30 --transition-duration 1 \
		--transition-pos "$cursorposx, $cursorposy_inverted"
}

# If no arguments are passed, choose a wallpaper using Thunar file dialog
if [[ "$1" == "" ]]; then
	# Use Thunar's file picker dialog
	chosen_wallpaper=$(thunar --no-desktop --action="open" --display=$DISPLAY)

	# Check if a file was chosen and set wallpaper
	if [ -n "$chosen_wallpaper" ]; then
		switch "$chosen_wallpaper"
	else
		echo "No file selected, aborting."
		exit 1
	fi
else
	# If a file path is passed as an argument, use it directly
	switch "$1"
fi
