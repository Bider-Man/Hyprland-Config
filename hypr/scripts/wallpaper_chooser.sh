#!/bin/bash

# Open the file manager to choose the wallpaper
chosen_wallpaper=$(zenity --file-selection --title="Select Wallpaper" --file-filter="Images|*.jpg;*.png;*.jpeg;*.bmp;*.gif")

# Check if a file was chosen
if [ -n "$chosen_wallpaper" ]; then
    # Set the chosen wallpaper using hyprpaper
    hyprctl dispatch background "$chosen_wallpaper" "1"
fi
