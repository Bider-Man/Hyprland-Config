#!/bin/bash

# Specify the default folder (adjust as needed)
default_folder="$HOME/Pictures"

# Open Zenity file picker to select an image file
wallpaper=$(zenity --file-selection --title="Select a Wallpaper" --file-filter="Image files|*.jpg;*.jpeg;*.png;*.bmp;*.gif" --directory="$default_folder")

# Check if the user selected a file
if [ -n "$wallpaper" ]; then
  # Set the selected wallpaper using swww
  swww img "$wallpaper"
  echo "Wallpaper changed to: $wallpaper"
else
  echo "No wallpaper selected."
fi
