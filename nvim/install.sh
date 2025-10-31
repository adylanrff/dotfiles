#!/bin/bash

set -e

echo "🚀 Installing Neovim Configuration..."

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

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

# Install build essentials (Linux only)
if [[ "$OS" == "ubuntu" ]] && ! dpkg -l | grep -q build-essential; then
    echo -e "${YELLOW}Installing build essentials...${NC}"
    sudo apt-get install -y build-essential
elif [[ "$OS" == "arch" ]] && ! is_installed gcc; then
    echo -e "${YELLOW}Installing base-devel...${NC}"
    sudo pacman -S --noconfirm base-devel
elif [[ "$OS" == "fedora" ]] && ! is_installed gcc; then
    echo -e "${YELLOW}Installing development tools...${NC}"
    sudo dnf groupinstall -y "Development Tools"
fi

# Install Neovim
echo -e "${YELLOW}📦 Checking Neovim installation...${NC}"
if is_installed nvim; then
    NVIM_VERSION=$(nvim --version | head -n1 | awk '{print $2}')
    echo -e "${GREEN}✓ Neovim $NVIM_VERSION found${NC}"
else
    echo -e "${YELLOW}Installing Neovim...${NC}"
    case "$OS" in
        macos)
            brew install neovim
            ;;
        arch)
            sudo pacman -S --noconfirm neovim
            ;;
        ubuntu)
            # For Ubuntu, install from unstable PPA to get latest version
            if ! grep -q "neovim-ppa/unstable" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
                sudo add-apt-repository -y ppa:neovim-ppa/unstable
                sudo apt-get update
            fi
            sudo apt-get install -y neovim
            ;;
        fedora)
            sudo dnf install -y neovim
            ;;
    esac
fi

# Install required tools
echo -e "${YELLOW}📦 Installing required tools...${NC}"

# Git
if ! is_installed git; then
    install_package git
fi

# ripgrep
if ! is_installed rg; then
    case "$OS" in
        macos|arch|fedora)
            install_package ripgrep
            ;;
        ubuntu)
            install_package ripgrep
            ;;
    esac
fi

# fd
if ! is_installed fd; then
    case "$OS" in
        macos)
            install_package fd
            ;;
        arch)
            install_package fd
            ;;
        ubuntu)
            install_package fd-find
            # Create symlink for fd-find -> fd
            if [ ! -f "$HOME/.local/bin/fd" ]; then
                mkdir -p "$HOME/.local/bin"
                ln -sf "$(which fdfind)" "$HOME/.local/bin/fd"
                export PATH="$HOME/.local/bin:$PATH"
            fi
            ;;
        fedora)
            install_package fd-find
            ;;
    esac
fi

# fzf
if ! is_installed fzf; then
    install_package fzf
fi

# lazygit
if ! is_installed lazygit; then
    case "$OS" in
        macos)
            install_package lazygit
            ;;
        arch)
            install_package lazygit
            ;;
        ubuntu)
            # Install from github releases for Ubuntu
            LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
            curl -Lo /tmp/lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
            tar xf /tmp/lazygit.tar.gz -C /tmp
            sudo install /tmp/lazygit /usr/local/bin
            ;;
        fedora)
            sudo dnf copr enable -y atim/lazygit
            install_package lazygit
            ;;
    esac
fi

# Make and cmake (needed for building)
if ! is_installed make; then
    case "$OS" in
        macos)
            # Already installed with Xcode Command Line Tools
            ;;
        ubuntu)
            sudo apt-get install -y make cmake
            ;;
        arch)
            sudo pacman -S --noconfirm make cmake
            ;;
        fedora)
            sudo dnf install -y make cmake
            ;;
    esac
fi

# Language-specific tools
echo -e "${YELLOW}📦 Installing language tools...${NC}"

# Go
if ! is_installed go; then
    echo -e "${YELLOW}Installing Go...${NC}"
    case "$OS" in
        macos)
            brew install go
            ;;
        arch)
            sudo pacman -S --noconfirm go
            ;;
        ubuntu)
            sudo add-apt-repository -y ppa:longsleep/golang-backports
            sudo apt-get update
            sudo apt-get install -y golang-go
            ;;
        fedora)
            sudo dnf install -y golang
            ;;
    esac
fi

# Ensure Go bin is in PATH
if [[ ":$PATH:" != *":$HOME/go/bin:"* ]]; then
    export PATH="$HOME/go/bin:$PATH"
fi

# Install Go tools
echo -e "${YELLOW}Installing Go tools (gopls, goimports, delve)...${NC}"
go install golang.org/x/tools/gopls@latest
go install golang.org/x/tools/cmd/goimports@latest
go install github.com/go-delve/delve/cmd/dlv@latest

# Rust
if ! is_installed rustc; then
    echo -e "${YELLOW}Installing Rust...${NC}"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
fi

# C/C++ compiler
if ! is_installed clang; then
    echo -e "${YELLOW}Installing C/C++ compiler...${NC}"
    case "$OS" in
        macos)
            if ! xcode-select -p &> /dev/null; then
                echo -e "${YELLOW}Installing Xcode Command Line Tools...${NC}"
                xcode-select --install
                echo -e "${YELLOW}Please complete the Xcode installation and re-run this script${NC}"
                exit 1
            fi
            ;;
        arch)
            sudo pacman -S --noconfirm clang
            ;;
        ubuntu)
            sudo apt-get install -y clang
            ;;
        fedora)
            sudo dnf install -y clang
            ;;
    esac
fi

# Node.js (for some LSP servers and tools)
if ! is_installed node; then
    echo -e "${YELLOW}Installing Node.js...${NC}"
    case "$OS" in
        macos)
            brew install node
            ;;
        arch)
            sudo pacman -S --noconfirm nodejs npm
            ;;
        ubuntu)
            curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
            sudo apt-get install -y nodejs
            ;;
        fedora)
            sudo dnf install -y nodejs npm
            ;;
    esac
fi

# Setup symlink
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
NVIM_CONFIG_DIR="$HOME/.config/nvim"

if [ -L "$NVIM_CONFIG_DIR" ]; then
    echo -e "${GREEN}✓ Symlink already exists${NC}"
elif [ -d "$NVIM_CONFIG_DIR" ]; then
    echo -e "${YELLOW}⚠ Existing nvim config found. Backing up to ~/.config/nvim.backup${NC}"
    mv "$NVIM_CONFIG_DIR" "$HOME/.config/nvim.backup"
    ln -sf "$SCRIPT_DIR" "$NVIM_CONFIG_DIR"
    echo -e "${GREEN}✓ Symlink created${NC}"
else
    mkdir -p "$HOME/.config"
    ln -sf "$SCRIPT_DIR" "$NVIM_CONFIG_DIR"
    echo -e "${GREEN}✓ Symlink created${NC}"
fi

# Bootstrap lazy.nvim and install plugins
echo -e "${YELLOW}📦 Installing Neovim plugins...${NC}"
nvim --headless "+Lazy! sync" +qa

# Install Mason packages
echo -e "${YELLOW}📦 Installing LSP servers and tools via Mason...${NC}"
nvim --headless "+MasonInstall clangd gopls rust-analyzer clang-format goimports stylua" +qa

# Build telescope-fzf-native
echo -e "${YELLOW}🔨 Building telescope-fzf-native...${NC}"
FZF_NATIVE_DIR="$HOME/.local/share/nvim/lazy/telescope-fzf-native.nvim"
if [ -d "$FZF_NATIVE_DIR" ]; then
    cd "$FZF_NATIVE_DIR" && make
fi

echo ""
echo -e "${GREEN}✅ Installation complete!${NC}"
echo ""
echo -e "Next steps:"
echo -e "  1. Restart your terminal (or run: source ~/.bashrc or source ~/.zshrc)"
echo -e "  2. Run ${YELLOW}nvim${NC} to start using your new config"
echo -e "  3. Everything should work out of the box!"
echo ""
echo -e "Useful commands:"
echo -e "  ${YELLOW}:Lazy${NC} - Manage plugins"
echo -e "  ${YELLOW}:Mason${NC} - Manage LSP servers and tools"
echo -e "  ${YELLOW}:checkhealth${NC} - Check configuration health"
echo ""

# Add PATH exports to shell rc files if needed
if [[ "$OS" != "macos" ]]; then
    SHELL_RC=""
    if [ -n "$ZSH_VERSION" ] || [ -f "$HOME/.zshrc" ]; then
        SHELL_RC="$HOME/.zshrc"
    elif [ -n "$BASH_VERSION" ] || [ -f "$HOME/.bashrc" ]; then
        SHELL_RC="$HOME/.bashrc"
    fi

    if [ -n "$SHELL_RC" ]; then
        echo -e "${YELLOW}Adding PATH exports to $SHELL_RC${NC}"

        # Add Go bin to PATH
        if ! grep -q "export PATH.*go/bin" "$SHELL_RC"; then
            echo 'export PATH="$HOME/go/bin:$PATH"' >> "$SHELL_RC"
        fi

        # Add cargo bin to PATH
        if ! grep -q "export PATH.*cargo/bin" "$SHELL_RC"; then
            echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> "$SHELL_RC"
        fi

        # Add local bin to PATH (for fd on Ubuntu)
        if [[ "$OS" == "ubuntu" ]] && ! grep -q "export PATH.*local/bin" "$SHELL_RC"; then
            echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$SHELL_RC"
        fi

        echo -e "${GREEN}✓ PATH exports added. Please restart your terminal or source $SHELL_RC${NC}"
    fi
fi
