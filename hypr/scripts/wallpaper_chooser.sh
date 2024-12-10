#!/bin/bash

# Set the file explorer you want to use (Thunar, Nautilus, Dolphin, etc.)
file_explorer="thunar"  # Change this if you use a different file manager

# Open the file manager to choose the wallpaper
chosen_wallpaper=$(zenity --file-selection --title="Select Wallpaper" --file-filter="Images|*.jpg;*.png;*.jpeg;*.bmp;*.gif")

# Check if a file was chosen
if [ -n "$chosen_wallpaper" ]; then
    # Set the chosen wallpaper using feh
    feh --bg-scale "$chosen_wallpaper"
fi
