# Animated Cyberpunk Wallpapers

This directory contains animated wallpapers for your Hyprland setup using `swww`.

## Recommended Sources for Cyberpunk Animated Wallpapers

1. **Pixabay** (Free, No Attribution Required)
   - https://pixabay.com/gifs/search/cyberpunk%20wallpaper/
   - Royalty-free cyberpunk GIFs

2. **WallpaperAccess** (Free Downloads)
   - https://wallpaperaccess.com/cyberpunk-gif
   - 56+ Cyberpunk GIF wallpapers

3. **MoeWalls** (HD Animated Videos)
   - https://moewalls.com/tag/cyberpunk/
   - 387+ Cyberpunk live wallpapers for PC

4. **MotionBgs** (4K Quality)
   - https://motionbgs.com/tag:cyberpunk/
   - 130+ Cyberpunk wallpapers in Full HD and 4K

## Supported Formats

- `.gif` - Animated GIFs
- `.mp4` - Video files
- `.webm` - WebM videos
- `.jpg` / `.png` - Static images

## Usage

1. Download your favorite cyberpunk wallpaper from the sources above
2. Save it to `~/.config/hypr/wallpapers/`
3. Run the wallpaper script:
   ```bash
   ~/.config/hypr/scripts/wallpaper.sh ~/.config/hypr/wallpapers/your-wallpaper.gif
   ```

Or let it auto-select:

```bash
~/.config/hypr/scripts/wallpaper.sh
```

## Auto-start on Login

The wallpaper script is automatically run on Hyprland startup (configured in autostart.conf).

## Quick Download Example

```bash
# Example: Download a free cyberpunk GIF from Pixabay
cd ~/.config/hypr/wallpapers/
# Visit https://pixabay.com/gifs/search/cyberpunk/ and download your favorite
```

## Tips

- For best performance, use GIF or WebM formats
- Recommended resolution: Match your monitor resolution
- For dual monitors, swww will span the wallpaper across both screens
