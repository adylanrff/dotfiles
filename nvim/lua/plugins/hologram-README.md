# Hologram.nvim Setup

Hologram.nvim allows you to view images directly in Neovim!

## Requirements

### ✅ Already Configured
- hologram.nvim plugin (lazy-loaded)
- Plugin configuration in `lua/plugins/hologram.lua`

### 📦 Install ueberzugpp (Required)

The plugin needs `ueberzugpp` to display images in Alacritty/tmux:

```bash
# Install via pacman
sudo pacman -S ueberzugpp

# Or run the install script (includes ueberzugpp in packages.arch)
./install.sh
```

## Usage

### Automatic Image Display
Images will automatically display in markdown files:
```bash
nvim README.md  # Images in markdown ![](image.png) will auto-display
```

To view standalone images, open them and they'll display via the Image API.

### Supported Formats
- PNG
- JPEG
- GIF
- WebP
- BMP

## Verification

After installing ueberzugpp, restart Neovim and check if hologram is loaded:
```vim
:Lazy
```

Look for "hologram.nvim" in the plugin list (it will only load if ueberzugpp is installed).

## Troubleshooting

### Plugin not loading?
Check if ueberzugpp is installed:
```bash
which ueberzugpp
```

### Images not displaying?
1. Make sure you're in a supported terminal (Alacritty works!)
2. Check if ueberzugpp is working:
```bash
ueberzugpp --help
```

3. Try opening an image file:
```bash
nvim ~/path/to/image.png
```

## Alternative: Use Kitty Terminal

For better performance, you can use Kitty terminal which has native image protocol support (no ueberzugpp needed):

```bash
sudo pacman -S kitty
```

Then update your Hyprland config to use kitty instead of Alacritty.

## References
- [hologram.nvim GitHub](https://github.com/edluffy/hologram.nvim)
- [ueberzugpp GitHub](https://github.com/jstkdng/ueberzugpp)
