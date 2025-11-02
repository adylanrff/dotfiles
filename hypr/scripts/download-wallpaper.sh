#!/bin/bash

# Helper script to download and set cyberpunk wallpapers
# Usage: download-wallpaper.sh [URL]

WALLPAPER_DIR="$HOME/.config/hypr/wallpapers"

echo "╔══════════════════════════════════════════════════════════╗"
echo "║       Cyberpunk Animated Wallpaper Downloader            ║"
echo "╚══════════════════════════════════════════════════════════╝"
echo ""

if [ -z "$1" ]; then
    echo "Here are some great sources for cyberpunk animated wallpapers:"
    echo ""
    echo "🌟 Free Sources (No Login Required):"
    echo "   1. Pixabay: https://pixabay.com/gifs/search/cyberpunk/"
    echo "   2. WallpaperAccess: https://wallpaperaccess.com/cyberpunk-gif"
    echo "   3. GIPHY: https://giphy.com/explore/cyberpunk"
    echo ""
    echo "🎬 Video Wallpapers (MP4/WebM):"
    echo "   1. MoeWalls: https://moewalls.com/tag/cyberpunk/"
    echo "   2. MotionBgs: https://motionbgs.com/tag:cyberpunk/"
    echo ""
    echo "📥 How to download:"
    echo "   1. Visit any of the above websites"
    echo "   2. Find a wallpaper you like"
    echo "   3. Download it"
    echo "   4. Run: $0 /path/to/downloaded/file"
    echo ""
    echo "Or use direct URL:"
    echo "   $0 https://example.com/cyberpunk.gif"
    echo ""
    exit 0
fi

URL="$1"

# Check if it's a local file or URL
if [ -f "$URL" ]; then
    # Local file
    filename=$(basename "$URL")
    echo "📁 Copying local file to wallpapers directory..."
    cp "$URL" "$WALLPAPER_DIR/$filename"
    WALLPAPER="$WALLPAPER_DIR/$filename"
else
    # URL - download it
    filename=$(basename "$URL" | sed 's/?.*//')  # Remove query params

    # If no extension, try to detect from content-type
    if [[ ! "$filename" =~ \.(gif|mp4|webm|jpg|png)$ ]]; then
        echo "⚠️  Warning: Could not detect file type. Trying anyway..."
        filename="cyberpunk-wallpaper-$(date +%s).gif"
    fi

    echo "📥 Downloading: $URL"
    echo "💾 Saving as: $filename"

    if command -v wget &> /dev/null; then
        wget -O "$WALLPAPER_DIR/$filename" "$URL"
    elif command -v curl &> /dev/null; then
        curl -L -o "$WALLPAPER_DIR/$filename" "$URL"
    else
        echo "❌ Error: Neither wget nor curl is installed"
        exit 1
    fi

    WALLPAPER="$WALLPAPER_DIR/$filename"
fi

if [ -f "$WALLPAPER" ]; then
    echo "✅ Wallpaper downloaded successfully!"
    echo "🎨 Setting wallpaper..."

    # Set the wallpaper
    ~/.config/hypr/scripts/wallpaper.sh "$WALLPAPER"

    echo ""
    echo "🌟 All done! Your cyberpunk wallpaper is now active!"
    echo "📂 Wallpaper saved to: $WALLPAPER"
else
    echo "❌ Error: Download failed"
    exit 1
fi
