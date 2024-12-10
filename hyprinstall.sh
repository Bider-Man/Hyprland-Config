#!/bin/bash

# Set variables for config file directories
CONFIG_DIR="$HOME/.config/hypr"
HYPRLAND_DIR="$CONFIG_DIR/hyprland"

# Create necessary directories if they don't exist
mkdir -p "$HYPRLAND_DIR"
mkdir -p "$CONFIG_DIR/scripts"

# Remove existing config files in ~/.config/hypr (optional)
echo "Removing old config files from $CONFIG_DIR..."
rm -rf "$CONFIG_DIR/hyprland/*"

# Install necessary dependencies
echo "Installing dependencies..."
sudo pacman -Syu --noconfirm \
    hyprland \
    foot \
    waybar \
    dunst \
    xdg-desktop-portal-hyprland \
    swww \
    pasystray \
    fcitx5 \
    swaylock \
    swayidle \
    nm-applet

# Copy configuration files into the config directory
echo "Copying config files..."
cp -r ./hyprland/* "$HYPRLAND_DIR"

# Copy the wallpaper chooser script to the scripts directory
cp ./scripts/wallpaper_chooser.sh "$CONFIG_DIR/scripts/"

# Set the correct permissions for configuration files
chmod -R 755 "$HYPRLAND_DIR"
chmod +x "$CONFIG_DIR/scripts/wallpaper_chooser.sh"

# Create symbolic links to ensure the config files are loaded (optional)
ln -sf "$HYPRLAND_DIR/hyprland.conf" "$HOME/.config/hyprland.conf"
ln -sf "$HYPRLAND_DIR/execs.conf" "$HOME/.config/hypr/execs.conf"
ln -sf "$HYPRLAND_DIR/colors.conf" "$HOME/.config/hypr/colors.conf"
ln -sf "$HYPRLAND_DIR/keybinds.conf" "$HOME/.config/hypr/keybinds.conf"
ln -sf "$HYPRLAND_DIR/rules.conf" "$HOME/.config/hypr/rules.conf"
ln -sf "$HYPRLAND_DIR/themes.conf" "$HOME/.config/hypr/themes.conf"
ln -sf "$HYPRLAND_DIR/env.conf" "$HOME/.config/hypr/env.conf"

# Create symbolic links for Waybar config if necessary
ln -sf "$HOME/.config/waybar/config" "$HOME/.config/waybar/config"
ln -sf "$HOME/.config/waybar/styles.css" "$HOME/.config/waybar/styles.css"

# Restart services if necessary
echo "Restarting Waybar and Hyprland..."

# Restart Waybar to load the new config
pkill waybar && waybar &

# Restart Hyprland (you can also use `hyprctl reload` for specific config reloading)
hyprctl reload

echo "Installation and configuration are complete!"
