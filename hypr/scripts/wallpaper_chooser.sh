#!/bin/bash

# Open Thunar file manager to choose the wallpaper and get the selected file path
chosen_wallpaper=$(thunar --choose --display=$DISPLAY)

# Check if a file was chosen
if [ -n "$chosen_wallpaper" ]; then
    # Set the chosen wallpaper using swww
    swww img "$chosen_wallpaper"
fi
