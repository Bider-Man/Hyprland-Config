#!/bin/bash

WALLPAPER_DIRECTORY=~/Wallpapers/

WALLPAPER=$(find "$WALLPAPER_DIRECTORY" -type f | shuf -n 1)

hyprctl hyprpaper preload "$WALLPAPER"
hyprctl hyprpaper wallpaper ", $WALLPAPER"

sleep 1

hyprctl hyprpaper unload unused
