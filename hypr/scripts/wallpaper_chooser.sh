#!/bin/bash

# Specify the default folder (adjust as needed)
default_folder="$HOME/Pictures"

# Use zenity to select a wallpaper file
wallpaper=$(zenity --file-selection --title="Select a Wallpaper" --file-filter="Image files|*.jpg;*.jpeg;*.png;*.bmp;*.gif" --directory="$default_folder")

# Check if a file was selected
if [ -n "$wallpaper" ]; then
  # Set the wallpaper using swww
  swww img "$wallpaper"
  echo "Wallpaper changed to: $wallpaper"
else
  echo "No wallpaper selected or dialog was canceled."
fi
