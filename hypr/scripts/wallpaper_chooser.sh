#!/bin/bash

# Default folder to open in the file chooser
default_folder="$HOME/Pictures"

# Open a file chooser dialog using Zenity
wallpaper=$(zenity --file-selection --filename="$default_folder/" --title="Select a Wallpaper")

# Check if the user canceled the selection
if [ -z "$wallpaper" ]; then
  echo "No file selected. Operation canceled."
  exit 1
fi

# Check if the selected path is a valid file
if [ -f "$wallpaper" ]; then
  # Set the wallpaper using swww
  swww img "$wallpaper"
  echo "Wallpaper changed to: $wallpaper"
else
  # If the selection is not a valid file
  echo "Selected path is not a valid file."
fi
