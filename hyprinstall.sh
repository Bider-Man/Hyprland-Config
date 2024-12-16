#!/bin/bash

# Define target directories
CONFIG_DIR="$HOME/.config/hypr"
HYPRLAND_DIR="$CONFIG_DIR/hyprland"
SCRIPTS_DIR="$CONFIG_DIR/scripts"
HYPRLOCK_DIR="$CONFIG_DIR/hyprlock"
WAYBAR_DIR="$HOME/.config/waybar"
FOOT_DIR="$HOME/.config/foot"
WAYBAR_SRC_DIR="./hypr/waybar"

# Clean up old configurations
echo "Cleaning up old configurations in $CONFIG_DIR..."
rm -rf "$CONFIG_DIR"
mkdir -p "$HYPRLAND_DIR"
mkdir -p "$SCRIPTS_DIR"
mkdir -p "$HYPRLOCK_DIR"  # Ensure the hyprlock directory exists

# Install dependencies
echo "Installing dependencies..."
sudo pacman -Syu --noconfirm \
    yay \
    hyprland \
    rofi \
    zenity \
    otf-font-awesome \
    ttf-arimo-nerd \
    noto-fonts-emoji \
    noto-fonts \
    foot \
    waybar \
    dunst \
    xdg-desktop-portal-hyprland \
    swww \
    pasystray \
    fcitx5 \
    swaylock \
    swayidle \
    wl-clipboard \
    grim \
    slurp \
    procps-ng \
    hypridle \
    hyprpaper \
    hyprlock \
    nautilus \
    kate \
    neovim \
    dunst 

yay -Syu --noconfirm \
    hyprsunset \
    hyprshot \

# Copy Hyprland folder
if [ -d "./hypr/hyprland" ]; then
  echo "Copying hyprland folder to $HYPRLAND_DIR..."
  cp -r ./hypr/hyprland/* "$HYPRLAND_DIR/"
else
  echo "Error: ./hypr/hyprland directory not found!"
  exit 1
fi

# Copy hyprlock folder
if [ -d "./hypr/hyprlock" ]; then
  echo "Copying hyprlock folder to $HYPRLOCK_DIR..."
  cp -r ./hypr/hyprlock/* "$HYPRLOCK_DIR/"
else
  echo "Error: ./hypr/hyprlock directory not found!"
  exit 1
fi

# Copy scripts folder
if [ -d "./hypr/scripts" ]; then
  echo "Copying scripts to $SCRIPTS_DIR..."
  cp -r ./hypr/scripts/* "$SCRIPTS_DIR/"
else
  echo "Error: ./hypr/scripts directory not found!"
  exit 1
fi

# Overwrite the auto-generated hyprland.conf
if [ -f "./hypr/hyprland.conf" ]; then
  echo "Overwriting hyprland.conf with the provided file..."
  cp ./hypr/hyprland.conf "$CONFIG_DIR/hyprland.conf"
else
  echo "Error: Provided hyprland.conf file not found in ./hypr!"
  exit 1
fi

# Copy hyprlock.conf and hypridle.conf
if [ -f "./hypr/hyprlock.conf" ]; then
  echo "Copying hyprlock.conf to $CONFIG_DIR..."
  cp ./hypr/hyprlock.conf "$CONFIG_DIR/hyprlock.conf"
else
  echo "Error: Provided hyprlock.conf file not found in ./hypr!"
  exit 1
fi

if [ -f "./hypr/hypridle.conf" ]; then
  echo "Copying hypridle.conf to $CONFIG_DIR..."
  cp ./hypr/hypridle.conf "$CONFIG_DIR/hypridle.conf"
else
  echo "Error: Provided hypridle.conf file not found in ./hypr!"
  exit 1
fi

# Create and copy foot configuration
if [ -d "$FOOT_DIR" ]; then
  echo "Foot configuration directory already exists at $FOOT_DIR."
else
  echo "Creating foot configuration directory at $FOOT_DIR..."
  mkdir -p "$FOOT_DIR"
fi

if [ -f "/etc/xdg/foot/foot.ini" ]; then
  echo "Copying /etc/xdg/foot/foot.ini to $FOOT_DIR..."
  cp /etc/xdg/foot/foot.ini "$FOOT_DIR/foot.ini"
else
  echo "Error: Default foot.ini not found in /etc/xdg/foot. Creating an empty configuration file."
  touch "$FOOT_DIR/foot.ini"
fi

# Create Rofi configuration
echo "Creating Rofi configuration directory and dumping default config..."
mkdir -p ~/.config/rofi
rofi -dump-config > ~/.config/rofi/config.rasi

# Handle Waybar configuration
if command -v waybar &> /dev/null; then
  echo "Waybar is installed. Configuring Waybar..."
  
  if [ -d "$WAYBAR_SRC_DIR" ]; then
    echo "Copying Waybar configuration from $WAYBAR_SRC_DIR to $WAYBAR_DIR..."
    mkdir -p "$WAYBAR_DIR"
    cp -r "$WAYBAR_SRC_DIR"/* "$WAYBAR_DIR/"
  else
    echo "Error: Waybar configuration folder $WAYBAR_SRC_DIR not found!"
    exit 1
  fi
else
  echo "Waybar is not installed. Skipping Waybar configuration."
fi

# Handle Dunst configuration
echo "Checking for Dunst configuration..."
if [ -d "/etc/dunst" ]; then
  echo "Dunst configuration found. Copying to ~/.config/dunst..."
  mkdir -p "$HOME/.config/dunst"
  cp -r /etc/dunst/* "$HOME/.config/dunst/"
else
  echo "Dunst configuration not found in /etc/dunst/. Skipping."
fi

# Handle Dunst configuration from local directory
echo "Copying Dunst configuration..."
if [ -d "./hypr/dunst" ]; then
  echo "Copying Dunst configuration from ./hypr/dunst to ~/.config/dunst..."
  mkdir -p "$HOME/.config/dunst"
  cp -r ./hypr/dunst/* "$HOME/.config/dunst/"
else
  echo "Error: ./hypr/dunst directory not found!"
  exit 1
fi


# Set correct permissions
echo "Setting permissions for configuration files..."
chmod -R 755 "$CONFIG_DIR"
chmod +x "$SCRIPTS_DIR/"*

# Restart Waybar and Hyprland to apply the new configurations
echo "Restarting Waybar and Hyprland..."

# Restart Waybar
pkill waybar && waybar &

# Reload Hyprland
hyprctl reload

echo "Installation and configuration complete!"
