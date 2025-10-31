#!/bin/bash

set -e

echo "🚀 Installing Dotfiles..."

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get script directory
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Detect OS and distro
detect_os() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        OS="macos"
    elif [[ -f /etc/os-release ]]; then
        . /etc/os-release
        case "$ID" in
            arch|manjaro)
                OS="arch"
                ;;
            ubuntu|debian|pop)
                OS="ubuntu"
                ;;
            fedora)
                OS="fedora"
                ;;
            *)
                OS="linux"
                ;;
        esac
    else
        OS="unknown"
    fi
    echo "$OS"
}

OS=$(detect_os)
echo -e "${GREEN}✓ Detected OS: $OS${NC}"

# Package manager commands
install_package() {
    local package=$1
    echo -e "${YELLOW}Installing $package...${NC}"

    case "$OS" in
        macos)
            brew install "$package"
            ;;
        arch)
            sudo pacman -S --noconfirm "$package"
            ;;
        ubuntu)
            sudo apt-get install -y "$package"
            ;;
        fedora)
            sudo dnf install -y "$package"
            ;;
        *)
            echo -e "${RED}❌ Unsupported OS${NC}"
            exit 1
            ;;
    esac
}

# Check if package is installed
is_installed() {
    command -v "$1" &> /dev/null
}

# Create symlink with backup
create_symlink() {
    local source=$1
    local target=$2
    local description=$3

    if [ -L "$target" ]; then
        echo -e "${GREEN}✓ $description symlink already exists${NC}"
    elif [ -e "$target" ]; then
        echo -e "${YELLOW}⚠ Existing $description found. Backing up to ${target}.backup${NC}"
        mv "$target" "${target}.backup"
        ln -sf "$source" "$target"
        echo -e "${GREEN}✓ $description symlink created${NC}"
    else
        mkdir -p "$(dirname "$target")"
        ln -sf "$source" "$target"
        echo -e "${GREEN}✓ $description symlink created${NC}"
    fi
}

echo ""
echo -e "${BLUE}=== Installing Package Manager ===${NC}"

# Install package manager if needed (macOS only)
if [[ "$OS" == "macos" ]] && ! is_installed brew; then
    echo -e "${YELLOW}Installing Homebrew...${NC}"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Update package lists (Linux only)
if [[ "$OS" == "ubuntu" ]]; then
    echo -e "${YELLOW}Updating package lists...${NC}"
    sudo apt-get update
elif [[ "$OS" == "arch" ]]; then
    echo -e "${YELLOW}Updating package lists...${NC}"
    sudo pacman -Sy
elif [[ "$OS" == "fedora" ]]; then
    echo -e "${YELLOW}Updating package lists...${NC}"
    sudo dnf check-update || true
fi

echo ""
echo -e "${BLUE}=== Installing Core Tools ===${NC}"

# Git
if ! is_installed git; then
    install_package git
fi

# curl and wget
if ! is_installed curl; then
    install_package curl
fi

echo ""
echo -e "${BLUE}=== Installing Zsh ===${NC}"

if ! is_installed zsh; then
    install_package zsh
fi

# Set zsh as default shell
if [[ "$SHELL" != *"zsh"* ]]; then
    echo -e "${YELLOW}Setting zsh as default shell...${NC}"
    chsh -s "$(which zsh)"
    echo -e "${GREEN}✓ Zsh set as default shell (will take effect on next login)${NC}"
fi

# Install Oh My Zsh if not present
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo -e "${YELLOW}Installing Oh My Zsh...${NC}"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Install zsh plugins
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    echo -e "${YELLOW}Installing zsh-autosuggestions...${NC}"
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    echo -e "${YELLOW}Installing zsh-syntax-highlighting...${NC}"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-completions" ]; then
    echo -e "${YELLOW}Installing zsh-completions...${NC}"
    git clone https://github.com/zsh-users/zsh-completions "$ZSH_CUSTOM/plugins/zsh-completions"
fi

echo ""
echo -e "${BLUE}=== Installing Tmux ===${NC}"

if ! is_installed tmux; then
    install_package tmux
fi

# Install TPM (Tmux Plugin Manager)
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    echo -e "${YELLOW}Installing TPM (Tmux Plugin Manager)...${NC}"
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

echo ""
echo -e "${BLUE}=== Installing Alacritty ===${NC}"

if ! is_installed alacritty; then
    case "$OS" in
        macos)
            brew install --cask alacritty
            ;;
        arch)
            sudo pacman -S --noconfirm alacritty
            ;;
        ubuntu)
            sudo add-apt-repository -y ppa:aslatter/ppa
            sudo apt-get update
            sudo apt-get install -y alacritty
            ;;
        fedora)
            sudo dnf install -y alacritty
            ;;
    esac
fi

echo ""
echo -e "${BLUE}=== Installing Neovim Configuration ===${NC}"

# Run nvim install script
if [ -f "$DOTFILES_DIR/nvim/install.sh" ]; then
    bash "$DOTFILES_DIR/nvim/install.sh"
else
    echo -e "${YELLOW}⚠ Neovim install script not found, skipping...${NC}"
fi

echo ""
echo -e "${BLUE}=== Creating Symlinks ===${NC}"

# Zsh
create_symlink "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc" "Zsh config"

# Tmux
create_symlink "$DOTFILES_DIR/tmux/tmux.conf" "$HOME/.tmux.conf" "Tmux config"
create_symlink "$DOTFILES_DIR/tmux/tmux.conf.local" "$HOME/.tmux.conf.local" "Tmux local config"

# Alacritty
create_symlink "$DOTFILES_DIR/alacritty/alacritty.toml" "$HOME/.config/alacritty/alacritty.toml" "Alacritty config"

# Scripts
if [ -d "$DOTFILES_DIR/scripts" ]; then
    mkdir -p "$HOME/.local/bin"
    for script in "$DOTFILES_DIR/scripts"/*; do
        if [ -f "$script" ]; then
            script_name=$(basename "$script")
            create_symlink "$script" "$HOME/.local/bin/$script_name" "Script: $script_name"
            chmod +x "$HOME/.local/bin/$script_name"
        fi
    done
fi

echo ""
echo -e "${BLUE}=== Post-Installation Setup ===${NC}"

# Install tmux plugins
echo -e "${YELLOW}Installing tmux plugins...${NC}"
if [ -d "$HOME/.tmux/plugins/tpm" ]; then
    "$HOME/.tmux/plugins/tpm/bin/install_plugins" || true
fi

# Add local bin to PATH if not already there
SHELL_RC=""
if [ -n "$ZSH_VERSION" ] || [ -f "$HOME/.zshrc" ]; then
    SHELL_RC="$HOME/.zshrc"
elif [ -n "$BASH_VERSION" ] || [ -f "$HOME/.bashrc" ]; then
    SHELL_RC="$HOME/.bashrc"
fi

if [ -n "$SHELL_RC" ]; then
    if ! grep -q "export PATH.*local/bin" "$SHELL_RC"; then
        echo -e "${YELLOW}Adding ~/.local/bin to PATH in $SHELL_RC${NC}"
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$SHELL_RC"
    fi
fi

echo ""
echo -e "${GREEN}✅ Dotfiles Installation Complete!${NC}"
echo ""
echo -e "Installed and configured:"
echo -e "  ${GREEN}✓${NC} Zsh with Oh My Zsh and plugins"
echo -e "  ${GREEN}✓${NC} Tmux with TPM and plugins"
echo -e "  ${GREEN}✓${NC} Alacritty terminal emulator"
echo -e "  ${GREEN}✓${NC} Neovim with full IDE setup"
echo -e "  ${GREEN}✓${NC} Custom scripts in ~/.local/bin"
echo ""
echo -e "Next steps:"
echo -e "  1. ${YELLOW}Restart your terminal${NC} (or run: source ~/.zshrc)"
echo -e "  2. ${YELLOW}Log out and log back in${NC} to switch to Zsh as default shell"
echo -e "  3. Open ${YELLOW}Alacritty${NC} as your new terminal"
echo -e "  4. Run ${YELLOW}tmux${NC} to start using tmux (prefix: Ctrl+a)"
echo -e "  5. Run ${YELLOW}nvim${NC} to start using Neovim"
echo ""
echo -e "Tmux notes:"
echo -e "  - Prefix key: ${YELLOW}Ctrl+a${NC}"
echo -e "  - Install plugins: ${YELLOW}Ctrl+a${NC} then ${YELLOW}I${NC} (capital i)"
echo -e "  - Reload config: ${YELLOW}Ctrl+a${NC} then ${YELLOW}r${NC}"
echo ""
echo -e "Zsh plugins enabled:"
echo -e "  - ${GREEN}zsh-autosuggestions${NC} (type commands, press → to accept)"
echo -e "  - ${GREEN}zsh-syntax-highlighting${NC} (correct commands in green)"
echo -e "  - ${GREEN}zsh-completions${NC} (better tab completions)"
echo ""
