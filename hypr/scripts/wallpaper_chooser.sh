#!/bin/bash

# Default folder to open in ranger
default_folder="$HOME/Pictures"

# Open ranger using foot terminal and let the user choose a file
wallpaper=$(foot -e ranger --choosefile="$default_folder")

# Trim any spaces or newlines from the selection
wallpaper=$(echo "$wallpaper" | tr -d '\n' | tr -d ' ')

# Check if the selected path is a valid file and not a directory
if [ -f "$wallpaper" ]; then
  # Set the wallpaper using swww
  swww img "$wallpaper"
  echo "Wallpaper changed to: $wallpaper"
elif [ -d "$wallpaper" ]; then
  # If a directory was selected
  echo "Selected path is a directory, not a file."
else
  # If the selection was invalid
  echo "Selected path is not a valid file."
fi
