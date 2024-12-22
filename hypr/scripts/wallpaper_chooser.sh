#!/bin/bash

# Default folder to open in ranger
default_folder="$HOME/Pictures"

# Open ranger using foot terminal and let the user choose a file
wallpaper=$(foot -e ranger --choosefile="$default_folder")

# Trim any spaces or newlines from the selection
wallpaper=$(echo "$wallpaper" | tr -d '\n' | tr -d ' ')

# Check if a valid file was selected and not a directory
if [ -f "$wallpaper" ]; then
  # Set the wallpaper using swww
  swww img "$wallpaper"
  echo "Wallpaper changed to: $wallpaper"
else
  # If the selection was not a valid file or directory was selected
  echo "Selected path is not a valid file or it is a directory."
fi
