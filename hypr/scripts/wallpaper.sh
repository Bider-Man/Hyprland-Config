#!/usr/bin/env bash

# Configuration
WALLPAPER_DIR=~/Wallpapers/
STATE_FILE=~/.cache/wallpaper_state
LOCK_FILE=/tmp/hyprpaper.lock
PRELOAD_CACHE=~/.cache/hyprpaper_preload.log

# -------------------------------------------------------------------
# Initialize hyprpaper with proper socket wait
ensure_hyprpaper() {
    if ! pgrep -x "hyprpaper" >/dev/null; then
        hyprpaper & disown
        # Wait until socket is actually available
        while [ ! -S /run/user/$(id -u)/hypr/*/.hyprpaper.sock ]; do
            sleep 0.1
        done
    fi
}

# -------------------------------------------------------------------
# Get wallpapers in natural sorted order (like file explorer)
get_wallpaper_list() {
    find "$WALLPAPER_DIR" -type f \( -name '*.jpg' -o -name '*.png' -o -name '*.jpeg' \) -print0 | \
        sort -zV | \
        xargs -0 -I{} realpath --relative-to="$WALLPAPER_DIR" {}
}

# -------------------------------------------------------------------
# Get current wallpaper index or initialize
get_current_index() {
    local count=$(get_wallpaper_list | wc -l)
    if [ ! -f "$STATE_FILE" ]; then
        echo 0 > "$STATE_FILE"
    fi
    
    local current_idx=$(<"$STATE_FILE")
    # Ensure index is within bounds
    if [ $current_idx -ge $count ]; then
        current_idx=0
        echo 0 > "$STATE_FILE"
    fi
    echo $current_idx
}

# -------------------------------------------------------------------
# Main execution with proper locking
exec 9>"$LOCK_FILE"
flock -n 9 || exit 0
trap 'flock -u 9' EXIT

ensure_hyprpaper

# Get all wallpapers
mapfile -t wallpapers < <(get_wallpaper_list)
[ ${#wallpapers[@]} -eq 0 ] && exit 1

# Get current position
current_idx=$(get_current_index)
current_wp="${WALLPAPER_DIR}${wallpapers[current_idx]}"

# Preload next wallpaper (for smooth transition)
next_idx=$(( (current_idx + 1) % ${#wallpapers[@]} ))
next_wp="${WALLPAPER_DIR}${wallpapers[next_idx]}"
hyprctl hyprpaper preload "$next_wp" >/dev/null 2>&1
echo "$next_wp" > "$PRELOAD_CACHE"

# Set current wallpaper (not next - this fixes the skip)
{
    hyprctl hyprpaper wallpaper ", $current_wp"
    sleep 0.2  # Ensure wallpaper is displayed
    
    # Only after displaying current, update to next position
    echo $next_idx > "$STATE_FILE"
} >/dev/null 2>&1
