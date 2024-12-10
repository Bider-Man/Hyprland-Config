#!/bin/bash

# Get the absolute path of the hyprland config folder
CONFIG_DIR="$(cd "$(dirname "$0")" && pwd)"

# Export the path as an environment variable
export HYPRLAND_CONFIG_DIR="$CONFIG_DIR"

# Launch Hyprland with the updated config directory
hyprland --config "$HYPRLAND_CONFIG_DIR/hyprland.conf"
