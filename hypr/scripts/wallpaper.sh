#!/bin/bash

# Wallpaper management script for swww
# Usage: wallpaper.sh [path_to_wallpaper]

WALLPAPER_DIR="$HOME/.config/hypr/wallpapers"
CURRENT_WALLPAPER="$HOME/.config/hypr/.current_wallpaper"

# Initialize swww daemon if not running
if ! pgrep -x swww-daemon > /dev/null; then
    swww-daemon &
    sleep 1
fi

# Function to set wallpaper
set_wallpaper() {
    local wallpaper="$1"

    if [ ! -f "$wallpaper" ]; then
        echo "Error: Wallpaper file not found: $wallpaper"
        exit 1
    fi

    # Set the wallpaper with transition
    swww img "$wallpaper" \
        --transition-type grow \
        --transition-pos 0.925,0.977 \
        --transition-fps 60 \
        --transition-duration 2

    # Save current wallpaper path
    echo "$wallpaper" > "$CURRENT_WALLPAPER"

    echo "Wallpaper set: $wallpaper"
}

# If argument provided, use it
if [ -n "$1" ]; then
    set_wallpaper "$1"
# Otherwise, use saved wallpaper or default
elif [ -f "$CURRENT_WALLPAPER" ]; then
    saved_wallpaper=$(cat "$CURRENT_WALLPAPER")
    if [ -f "$saved_wallpaper" ]; then
        set_wallpaper "$saved_wallpaper"
    else
        echo "Saved wallpaper not found, please specify a wallpaper"
        exit 1
    fi
else
    # Find any wallpaper in the directory
    wallpaper=$(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.gif" -o -name "*.mp4" -o -name "*.webm" \) | head -n 1)

    if [ -n "$wallpaper" ]; then
        set_wallpaper "$wallpaper"
    else
        echo "No wallpapers found in $WALLPAPER_DIR"
        exit 1
    fi
fi
