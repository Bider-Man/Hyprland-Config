#!/bin/bash

# Default folder to open in ranger
default_folder="$HOME/Pictures"

# Open ranger with foot terminal and allow the user to select a file
wallpaper=$(foot -e ranger --choosefile="$default_folder")

# Check if a file was selected
if [ -n "$wallpaper" ]; then
  # Set the wallpaper using swww
  swww img "$wallpaper"
  echo "Wallpaper changed to: $wallpaper"
else
  echo "No wallpaper selected or dialog was canceled."
fi
