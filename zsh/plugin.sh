#!/bin/bash

# ZSH Plugin Installer Script
# This script installs Oh My Zsh and popular ZSH plugins to enhance your shell experience.

# Install Oh My Zsh
echo "Installing Oh My Zsh..."
wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -

# Install ZSH Plugins
echo "Installing ZSH plugins..."

# zsh-autosuggestions: Fish-like autosuggestions for Zsh
echo "Installing zsh-autosuggestions..."
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

# zsh-syntax-highlighting: Syntax highlighting for Zsh
echo "Installing zsh-syntax-highlighting..."
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

# zsh-completions: Additional completion definitions for Zsh
echo "Installing zsh-completions..."
git clone https://github.com/zsh-users/zsh-completions.git ~/.oh-my-zsh/custom/plugins/zsh-completions

# zsh-history-substring-search: Fish-like history search for Zsh
echo "Installing zsh-history-substring-search..."
git clone https://github.com/zsh-users/zsh-history-substring-search.git ~/.oh-my-zsh/custom/plugins/zsh-history-substring-search

echo "Installation complete! Please restart your terminal or source your .zshrc file."
