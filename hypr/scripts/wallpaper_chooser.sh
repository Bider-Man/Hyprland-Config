#!/bin/bash

# Open Thunar to choose the wallpaper
chosen_wallpaper=$(thunar --no-desktop --action="open" --display=$DISPLAY)

# Check if a file was chosen
if [ -n "$chosen_wallpaper" ]; then
    # Set the chosen wallpaper using swww
    swww img "$chosen_wallpaper"
fi