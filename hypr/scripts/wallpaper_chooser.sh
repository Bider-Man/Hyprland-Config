#!/bin/bash

# Default folder to open in ranger
default_folder="$HOME/Pictures"

# Open ranger using foot terminal and let the user choose a file
wallpaper=$(foot -e ranger --choosefile="$default_folder")

# Trim any spaces or newlines from the selection
wallpaper=$(echo "$wallpaper" | tr -d '\n' | tr -d ' ')

# Check if a valid file was selected
if [ -f "$wallpaper" ]; then
  # Set the wallpaper using swww
  swww img "$wallpaper"
  echo "Wallpaper changed to: $wallpaper"
else
  echo "No valid wallpaper selected or dialog was canceled."
fi
