# 🌆 Recommended Cyberpunk Animated Wallpapers

Based on quality, performance, and availability, here are the best cyberpunk animated wallpapers:

## 🏆 Top Picks (18-40MB, 1920x1080)

### 1. Cyberpunk Rain City Pixel ⭐ BEST
- **Source**: https://moewalls.com/pixel-art/cyberpunk-rain-city-pixel-live-wallpaper/
- **Size**: 18.1 MB
- **Resolution**: 1920x1080
- **Style**: Pixel art, rainy cyberpunk city
- **Performance**: Excellent for laptops

### 2. Night City Rain (Cyberpunk 2077)
- **Source**: https://moewalls.com/sci-fi/night-city-rain-cyberpunk-2077-live-wallpaper/
- **Resolution**: 1920x1080
- **Style**: Cinematic cyberpunk city with rain
- **Performance**: Good

### 3. Cyberpunk McLaren Rainy Night
- **Source**: https://motionbgs.com/cyberpunk-mclaren-on-a-rainy-night
- **Size**: 41.9 MB
- **Resolution**: 1920x1080
- **Style**: Sports car in neon-lit rainy city
- **Performance**: Good

### 4. Tokyo Cyberpunk City Rain On Window
- **Source**: https://vsthemes.org/en/wallpapers/abstract/65226-tokyo-cyberpunk-city-ambience-rain-.html
- **Size**: 120.97 MB
- **Resolution**: 4K
- **Style**: Rain on window with city view
- **Performance**: High-end systems only

## 📥 Quick Download Guide

### Step 1: Visit the website
Click on any of the links above

### Step 2: Download
Click the green "Download Wallpaper" or "Download" button

### Step 3: Set as wallpaper
```bash
# After downloading to ~/Downloads/
~/.config/hypr/scripts/download-wallpaper.sh ~/Downloads/your-wallpaper.mp4
```

Or if you have the direct URL:
```bash
~/.config/hypr/scripts/download-wallpaper.sh "https://direct-url-to-file.mp4"
```

## 🎨 Alternative: Use Static Image First

If you want to test the setup with a static image first:
```bash
# Download a static cyberpunk image (smaller, faster)
cd ~/.config/hypr/wallpapers/
wget "https://images.unsplash.com/photo-1606654097304-f5f86e0d4d2e" -O cyberpunk-static.jpg
~/.config/hypr/scripts/wallpaper.sh ~/.config/hypr/wallpapers/cyberpunk-static.jpg
```

## 💡 Pro Tips

1. **For dual monitors**: swww will automatically span the wallpaper across both screens
2. **For better performance**: Use 1920x1080 instead of 4K
3. **File formats**: MP4 and WebM work best (GIFs work but can be laggy)
4. **Loop quality**: Look for seamless loop wallpapers for best effect

## 🔧 Troubleshooting

If wallpaper doesn't load:
```bash
# Restart swww daemon
killall swww-daemon
~/.config/hypr/scripts/wallpaper.sh
```

If performance is poor:
- Try a lower resolution wallpaper
- Use GIF instead of MP4
- Check CPU usage: `htop` or `top`
