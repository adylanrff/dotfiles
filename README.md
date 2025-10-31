# Dotfiles

A complete, cross-platform development environment configuration for macOS and Linux.

## 🚀 One-Command Installation

**Works on macOS, Arch Linux, Ubuntu/Debian, and Fedora:**

```bash
git clone <your-repo-url> ~/Documents/Projects/dotfiles
cd ~/Documents/Projects/dotfiles
./install.sh
```

That's it! Everything will be automatically installed and configured.

## ✨ What's Included

### Shell
- **Zsh** with Oh My Zsh framework
- **Plugins**:
  - `zsh-autosuggestions` - Command suggestions as you type
  - `zsh-syntax-highlighting` - Syntax highlighting for commands
  - `zsh-completions` - Additional completion definitions
- Custom `.zshrc` with aliases and configurations

### Terminal Emulator
- **Alacritty** - Fast, GPU-accelerated terminal
- Pre-configured with optimized settings
- Custom color scheme

### Terminal Multiplexer
- **Tmux** - Terminal multiplexer for managing multiple sessions
- **TPM (Tmux Plugin Manager)** with plugins
- Custom keybindings (Prefix: `Ctrl+a`)
- Status bar configuration

### Editor
- **Neovim** - Modern Vim-based editor
- Complete IDE setup with:
  - LSP support (C/C++, Go, Rust)
  - Auto-completion
  - Debugging (DAP)
  - Git integration
  - File explorer, fuzzy finder
  - 30+ plugins configured
- See [nvim/README.md](nvim/README.md) for full details

### Scripts
- Custom utility scripts in `~/.local/bin`

## 📦 Installed Tools

The installer automatically installs:

**Core:**
- Git, curl, wget
- Zsh + Oh My Zsh
- Tmux + TPM
- Alacritty
- Neovim (v0.11+)

**Development:**
- Go + gopls + goimports + delve
- Rust + rust-analyzer + rustfmt
- Clang/GCC + clangd + clang-format
- Node.js + npm

**CLI Tools:**
- ripgrep (rg)
- fd
- fzf
- lazygit

**Build Tools:**
- make, cmake, gcc/clang

## 🗂️ Repository Structure

```
dotfiles/
├── alacritty/           # Alacritty terminal config
│   └── alacritty.toml
├── nvim/                # Neovim configuration
│   ├── init.lua
│   ├── lua/
│   │   └── plugins/    # Plugin configurations
│   ├── install.sh      # Neovim-specific installer
│   └── README.md       # Detailed Neovim docs
├── tmux/                # Tmux configuration
│   ├── tmux.conf
│   ├── tmux.conf.local
│   └── plugins/        # Tmux plugins
├── zsh/                 # Zsh configuration
│   ├── .zshrc
│   └── plugin.sh
├── scripts/             # Custom utility scripts
├── install.sh          # Main installer (this installs everything)
└── README.md           # This file
```

## 🔧 Manual Installation

If you prefer to install manually or want to pick specific components:

### Prerequisites
- macOS, Arch Linux, Ubuntu/Debian, or Fedora
- sudo access (for Linux)

### Install Components Individually

**Zsh:**
```bash
# Install zsh
brew install zsh  # macOS
sudo pacman -S zsh  # Arch
sudo apt install zsh  # Ubuntu

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Symlink config
ln -sf ~/Documents/Projects/dotfiles/zsh/.zshrc ~/.zshrc
```

**Tmux:**
```bash
# Install tmux
brew install tmux  # macOS
sudo pacman -S tmux  # Arch
sudo apt install tmux  # Ubuntu

# Install TPM
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Symlink configs
ln -sf ~/Documents/Projects/dotfiles/tmux/tmux.conf ~/.tmux.conf
ln -sf ~/Documents/Projects/dotfiles/tmux/tmux.conf.local ~/.tmux.conf.local
```

**Alacritty:**
```bash
# Install alacritty
brew install --cask alacritty  # macOS
sudo pacman -S alacritty  # Arch
sudo apt install alacritty  # Ubuntu

# Symlink config
mkdir -p ~/.config/alacritty
ln -sf ~/Documents/Projects/dotfiles/alacritty/alacritty.toml ~/.config/alacritty/alacritty.toml
```

**Neovim:**
```bash
cd ~/Documents/Projects/dotfiles/nvim
./install.sh
```

## ⌨️ Key Features & Usage

### Zsh
- Type any command and press `→` to accept autosuggestions
- Valid commands appear in green, invalid in red
- Enhanced tab completions

### Tmux
- **Prefix**: `Ctrl+a` (instead of default `Ctrl+b`)
- **New window**: `Ctrl+a c`
- **Split vertical**: `Ctrl+a |`
- **Split horizontal**: `Ctrl+a -`
- **Switch panes**: `Ctrl+a arrow keys`
- **Install plugins**: `Ctrl+a I` (capital I)
- **Reload config**: `Ctrl+a r`

### Alacritty
- GPU-accelerated, extremely fast
- Configured with sensible defaults
- Custom keybindings

### Neovim
See [nvim/README.md](nvim/README.md) for complete keybindings and features.

Quick shortcuts:
- `<Space>` - Leader key
- `<Space>e` - File explorer
- `<Space>ff` - Find files
- `<Space>/` - Search in project
- `<Space>gg` - LazyGit

## 🔄 Updating

To update your dotfiles:

```bash
cd ~/Documents/Projects/dotfiles
git pull
./install.sh  # Re-run installer to update everything
```

Individual components:
```bash
# Update Neovim plugins
nvim +Lazy! sync +qa

# Update tmux plugins
~/.tmux/plugins/tpm/bin/update_plugins all

# Update Oh My Zsh
omz update
```

## 🌍 Platform Support

| OS | Status | Package Manager |
|---|---|---|
| macOS | ✅ Fully Supported | Homebrew |
| Arch Linux | ✅ Fully Supported | pacman |
| Manjaro | ✅ Fully Supported | pacman |
| Ubuntu/Debian | ✅ Fully Supported | apt |
| Pop!_OS | ✅ Fully Supported | apt |
| Fedora | ✅ Fully Supported | dnf |
| Other Linux | ⚠️ May work | Manual install |

## 🐛 Troubleshooting

### Zsh not default shell
```bash
chsh -s $(which zsh)
# Log out and log back in
```

### Tmux plugins not loading
```bash
# In tmux, press: Ctrl+a I (capital I)
# Or manually:
~/.tmux/plugins/tpm/bin/install_plugins
```

### Alacritty font issues
Install a Nerd Font:
```bash
brew tap homebrew/cask-fonts
brew install --cask font-hack-nerd-font
```

### Neovim issues
```bash
nvim
:checkhealth  # Diagnose issues
:Lazy sync    # Update plugins
:Mason        # Manage LSP servers
```

## 📝 Customization

All configurations are modular and can be customized:

- **Zsh**: Edit `zsh/.zshrc`
- **Tmux**: Edit `tmux/tmux.conf` and `tmux/tmux.conf.local`
- **Alacritty**: Edit `alacritty/alacritty.toml`
- **Neovim**: See `nvim/README.md` for plugin customization

After making changes, re-run `./install.sh` or manually create symlinks.

## 🚨 Uninstallation

To remove all dotfiles:

```bash
# Remove symlinks
rm ~/.zshrc
rm ~/.tmux.conf ~/.tmux.conf.local
rm -rf ~/.config/alacritty
rm -rf ~/.config/nvim

# Restore backups if they exist
mv ~/.zshrc.backup ~/.zshrc
mv ~/.config/nvim.backup ~/.config/nvim
# etc...
```

## 📚 Resources

- [Neovim](https://neovim.io/)
- [Tmux](https://github.com/tmux/tmux)
- [Alacritty](https://alacritty.org/)
- [Oh My Zsh](https://ohmyz.sh/)
- [Lazy.nvim](https://github.com/folke/lazy.nvim)

## 📄 License

Feel free to use and modify these dotfiles for your own setup!
