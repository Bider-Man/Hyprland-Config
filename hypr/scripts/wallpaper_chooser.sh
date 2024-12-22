#!/bin/bash

# Prompt the user to select a wallpaper using zenity
wallpaper=$(zenity --file-selection --title="Select a Wallpaper" --file-filter="Image files|*.jpg;*.jpeg;*.png;*.bmp;*.gif")

# Check if the user selected a file
if [ -n "$wallpaper" ]; then
  # Set the selected wallpaper using swww
  swww img "$wallpaper"
  echo "Wallpaper changed to: $wallpaper"
else
  echo "No wallpaper selected."
fi
