#!/bin/bash

# Specify your default directory (adjust as needed)
default_folder="$HOME/Pictures"

# Use rofi to select a wallpaper
wallpaper=$(find "$default_folder" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.bmp" -o -iname "*.gif" \) | rofi -dmenu -p "Select a Wallpaper")

# Check if the user selected a file
if [ -n "$wallpaper" ]; then
  # Set the selected wallpaper using swww
  swww img "$wallpaper"
  echo "Wallpaper changed to: $wallpaper"
else
  echo "No wallpaper selected."
fi
