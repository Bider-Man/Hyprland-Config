#!/bin/bash

# Define target directories
CONFIG_DIR="$HOME/.config/hypr"
HYPRLAND_DIR="$CONFIG_DIR/hyprland"
SCRIPTS_DIR="$CONFIG_DIR/scripts"
WAYBAR_DIR="$HOME/.config/waybar"
FOOT_DIR="$HOME/.config/foot"

# Clean up old configurations
echo "Cleaning up old configurations in $CONFIG_DIR..."
rm -rf "$CONFIG_DIR"
mkdir -p "$HYPRLAND_DIR"
mkdir -p "$SCRIPTS_DIR"

# Copy Hyprland folder
if [ -d "./hypr/hyprland" ]; then
  echo "Copying hyprland folder to $HYPRLAND_DIR..."
  cp -r ./hypr/hyprland/* "$HYPRLAND_DIR/"
else
  echo "Error: ./hypr/hyprland directory not found!"
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

# Install dependencies
echo "Installing dependencies..."
sudo pacman -Syu --noconfirm \
    hyprland \
    rofi \
    zenity \
    otf-font-awesome \
    ttf-arimo-nerd \
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
    wl-clipboard

# Create Rofi configuration
echo "Creating Rofi configuration directory and dumping default config..."
mkdir -p ~/.config/rofi
rofi -dump-config > ~/.config/rofi/config.rasi

# Handle Waybar configuration
if command -v waybar &> /dev/null; then
  echo "Waybar is installed. Configuring Waybar..."

  # Copy Waybar folder if exists
  if [ -d "./waybar" ]; then
    echo "Copying Waybar configuration folder to $WAYBAR_DIR..."
    rm -rf "$WAYBAR_DIR" # Remove any existing Waybar configuration
    cp -r ./waybar "$WAYBAR_DIR"
  else
    echo "Error: Waybar configuration folder ./waybar not found!"
    exit 1
  fi

  # Check for default Waybar config and style
  DEFAULT_WAYBAR_CONFIG="/etc/xdg/waybar/config"
  DEFAULT_WAYBAR_STYLE="/etc/xdg/waybar/style.css"

  if [ ! -f "$WAYBAR_DIR/config" ] && [ -f "$DEFAULT_WAYBAR_CONFIG" ]; then
    echo "Copying default Waybar config to $WAYBAR_DIR..."
    cp "$DEFAULT_WAYBAR_CONFIG" "$WAYBAR_DIR/config"
  fi

  if [ ! -f "$WAYBAR_DIR/style.css" ] && [ -f "$DEFAULT_WAYBAR_STYLE" ]; then
    echo "Copying default Waybar style to $WAYBAR_DIR..."
    cp "$DEFAULT_WAYBAR_STYLE" "$WAYBAR_DIR/style.css"
  fi
else
  echo "Waybar is not installed. Skipping Waybar configuration."
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
