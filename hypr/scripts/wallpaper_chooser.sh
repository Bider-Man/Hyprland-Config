#!/bin/bash

# Open ranger in the Pictures directory and allow the user to select a file
wallpaper=$(ranger --choosefile=/tmp/wallpaper.txt "$HOME/Pictures")

# Check if a file was selected
if [ -f "$wallpaper" ]; then
  # Set the wallpaper using swww
  swww img "$wallpaper"
  echo "Wallpaper changed to: $wallpaper"
else
  echo "No wallpaper selected."
fi
