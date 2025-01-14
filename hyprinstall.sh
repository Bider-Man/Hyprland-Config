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

# Install core dependencies
echo "Installing core dependencies with pacman..."
sudo pacman -Syu --noconfirm \
    rofi \
    zenity \
    otf-ipafont \
    ttf-dejavu \
    ttf-liberation \
    noto-fonts \
    noto-fonts-cjk \
    noto-fonts-emoji \
    foot \
    vala \
    meson \
    git \
    scdoc \
    sassc \
    gtk3 \
    gtk-layer-shell \
    dbus \
    glib2 \
    gobject-introspection \
    libgee \
    json-glib \
    libhandy \
    gvfs \
    granite \
    libpulse \
    libnotify \
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
    dunst \
    brightnessctl \
    pamixer \
    blueman \
    bluez \
    bluez-utils \
    python \
    obsidian \
    wlroots \
    wireplumber \
    glibc \
    pango \
    gdk-pixbuf2 \
    libdbusmenu-gtk3 \
    cairo \
    gcc-libs \
    fish \
    ttf-fira-code \
    feh \
    wofi \
    ranger \
    papirus-icon-theme \
    calcurse \
    imagemagick \
    acpi \
    pavucontrol \
    timeshift

# Install additional AUR packages using yay
echo "Installing additional AUR packages with yay..."
yay -Syu --noconfirm \
    hyprsunset \
    swaync \
    hyprland-qtutils \
    volnoti \
    hyprshot \
    wlogout \
    aylurs-gtk-shell-git \
    wireplumber \
    libgtop \
    bluez \
    bluez-utils \
    networkmanager \
    dart-sass \
    wl-clipboard \
    upower \
    gvfs \

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

if [ -f "./hypr/foot/foot.ini" ]; then
  echo "Copying foot.ini from ./hypr/foot/ to $FOOT_DIR..."
  cp ./hypr/foot/foot.ini "$FOOT_DIR/foot.ini"
else
  echo "Error: Provided foot.ini file not found in ./hypr/foot!"
  exit 1
fi

# Create Rofi configuration
echo "Creating Rofi configuration directory and dumping default config..."
mkdir -p ~/.config/rofi
rofi -dump-config > ~/.config/rofi/config.rasi

# Create and copy eww configuration
EWW_DIR="$HOME/.config/eww"

echo "Setting up eww configuration..."

# Check if the target eww directory exists, if not, create it
if [ -d "$EWW_DIR" ]; then
  echo "Eww configuration directory already exists at $EWW_DIR."
else
  echo "Creating eww configuration directory at $EWW_DIR..."
  mkdir -p "$EWW_DIR"
fi

# Check if the source eww folder exists and copy its contents
if [ -d "./hypr/eww" ]; then
  echo "Copying eww folder from ./hypr/eww to $EWW_DIR..."
  cp -r ./hypr/eww/* "$EWW_DIR/"
else
  echo "Error: Provided eww folder not found in ./hypr/eww!"
  exit 1
fi

echo "Eww configuration setup completed successfully!"


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

# Handle swaync configuration
echo "Checking for swaync configuration..."
if [ -d "/etc/xdg/swaync" ]; then
  echo "swaync configuration found. Copying to ~/.config/swaync..."
  mkdir -p "$HOME/.config/swaync"
  cp -r /etc/xdg/swaync/* "$HOME/.config/swaync/"
else
  echo "swaync configuration not found in /etc/xdg/swaync/. Skipping."
fi

# Handle Dunst configuration from local directory
echo "Copying swaync configuration..."
if [ -d "./hypr/swaync" ]; then
  echo "Copying Dunst configuration from ./hypr/swaync to ~/.config/swaync..."
  mkdir -p "$HOME/.config/swaync"
  cp -r ./hypr/swaync/* "$HOME/.config/swaync/"
else
  echo "Error: ./hypr/swaync directory not found!"
  exit 1
fi

# Create and handle Rofi configuration
echo "Setting up Rofi configuration..."

# Ensure the Rofi configuration directory exists
mkdir -p "$HOME/.config/rofi"

# Check if a local Rofi directory exists and copy its contents
if [ -d "./hypr/rofi" ]; then
  echo "Copying Rofi configuration from ./hypr/rofi to ~/.config/rofi..."
  cp -r ./hypr/rofi/* "$HOME/.config/rofi/"
else
  echo "No local Rofi configuration directory found. Dumping default Rofi configuration..."
  rofi -dump-config > "$HOME/.config/rofi/config.rasi"
fi

# Set correct permissions
echo "Setting permissions for configuration files..."
chmod -R 755 "$CONFIG_DIR"
chmod +x "$SCRIPTS_DIR/"*

# Restart Waybar and Hyprland to apply the new configurations
echo "Restarting Hyprland..."

# Reload Hyprland
hyprctl reload

echo "Installation and configuration complete!"
