#!/bin/bash

# Specify the default folder (adjust as needed)
default_folder="$HOME/Pictures"

# Open Thunar and let the user select a file
wallpaper=$(thunar --no-desktop --select "$default_folder" | tail -n 1)

# Check if the user selected a file
if [ -n "$wallpaper" ]; then
  # Set the selected wallpaper using swww
  swww img "$wallpaper"
  echo "Wallpaper changed to: $wallpaper"
else
  echo "No wallpaper selected."
fi
