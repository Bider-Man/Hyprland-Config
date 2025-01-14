#!/bin/bash

# Define target directories
CONFIG_DIR="$HOME/.config/hypr"
HYPRLAND_DIR="$CONFIG_DIR/hyprland"
SCRIPTS_DIR="$CONFIG_DIR/scripts"
HYPRLOCK_DIR="$CONFIG_DIR/hyprlock"
FOOT_DIR="$HOME/.config/foot"

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
    ags-hyprpanel-git \
    hyprsunset \
    hyprland-qtutils \
    volnoti \
    hyprshot \
    wlogout \
    libgtop \
    networkmanager \
    dart-sass \
    upower \
    gvfs

# Copy Hyprland folder
if [ -d "./HYPRLAND-CONFIG/hypr/hyprland" ]; then
  echo "Copying hyprland folder to $HYPRLAND_DIR..."
  cp -r ./HYPRLAND-CONFIG/hypr/hyprland/* "$HYPRLAND_DIR/"
else
  echo "Error: ./HYPRLAND-CONFIG/hypr/hyprland directory not found!"
  exit 1
fi

# Copy hyprlock folder
if [ -d "./HYPRLAND-CONFIG/hypr/hyprlock" ]; then
  echo "Copying hyprlock folder to $HYPRLOCK_DIR..."
  cp -r ./HYPRLAND-CONFIG/hypr/hyprlock/* "$HYPRLOCK_DIR/"
else
  echo "Error: ./HYPRLAND-CONFIG/hypr/hyprlock directory not found!"
  exit 1
fi

# Copy scripts folder
if [ -d "./HYPRLAND-CONFIG/hypr/scripts" ]; then
  echo "Copying scripts to $SCRIPTS_DIR..."
  cp -r ./HYPRLAND-CONFIG/hypr/scripts/* "$SCRIPTS_DIR/"
else
  echo "Error: ./HYPRLAND-CONFIG/hypr/scripts directory not found!"
  exit 1
fi

# Overwrite the auto-generated hyprland.conf
if [ -f "./HYPRLAND-CONFIG/hypr/hyprland.conf" ]; then
  echo "Overwriting hyprland.conf with the provided file..."
  cp ./HYPRLAND-CONFIG/hypr/hyprland.conf "$CONFIG_DIR/hyprland.conf"
else
  echo "Error: Provided hyprland.conf file not found in ./HYPRLAND-CONFIG/hypr!"
  exit 1
fi

# Copy hyprlock.conf and hypridle.conf
if [ -f "./HYPRLAND-CONFIG/hypr/hyprlock.conf" ]; then
  echo "Copying hyprlock.conf to $CONFIG_DIR..."
  cp ./HYPRLAND-CONFIG/hypr/hyprlock.conf "$CONFIG_DIR/hyprlock.conf"
else
  echo "Error: Provided hyprlock.conf file not found in ./HYPRLAND-CONFIG/hypr!"
  exit 1
fi

if [ -f "./HYPRLAND-CONFIG/hypr/hypridle.conf" ]; then
  echo "Copying hypridle.conf to $CONFIG_DIR..."
  cp ./HYPRLAND-CONFIG/hypr/hypridle.conf "$CONFIG_DIR/hypridle.conf"
else
  echo "Error: Provided hypridle.conf file not found in ./HYPRLAND-CONFIG/hypr!"
  exit 1
fi

# Create and copy foot configuration
if [ -d "$FOOT_DIR" ]; then
  echo "Foot configuration directory already exists at $FOOT_DIR."
else
  echo "Creating foot configuration directory at $FOOT_DIR..."
  mkdir -p "$FOOT_DIR"
fi

if [ -f "./HYPRLAND-CONFIG/hypr/foot/foot.ini" ]; then
  echo "Copying foot.ini from ./HYPRLAND-CONFIG/hypr/foot/ to $FOOT_DIR..."
  cp ./HYPRLAND-CONFIG/hypr/foot/foot.ini "$FOOT_DIR/foot.ini"
else
  echo "Error: Provided foot.ini file not found in ./HYPRLAND-CONFIG/hypr/foot!"
  exit 1
fi

# Set correct permissions
echo "Setting permissions for configuration files..."
chmod -R 755 "$CONFIG_DIR"
chmod +x "$SCRIPTS_DIR/"*

# Restart Hyprland to apply the new configurations
echo "Restarting Hyprland..."

# Reload Hyprland
hyprctl reload

echo "Installation and configuration complete!"
