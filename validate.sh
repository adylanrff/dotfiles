#!/bin/bash

# Validate dotfiles are in correct state before installation

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "🔍 Validating dotfiles structure..."
echo ""

ERRORS=0

# Check if critical config files are real files (not symlinks)
declare -a critical_files=(
    "alacritty/alacritty.toml"
    "zsh/.zshrc"
    "tmux/tmux.conf"
    "git/.gitconfig"
    "git/.gitignore_global"
)

for file in "${critical_files[@]}"; do
    full_path="$DOTFILES_DIR/$file"

    if [ ! -e "$full_path" ]; then
        echo -e "${RED}❌ Missing: $file${NC}"
        ERRORS=$((ERRORS + 1))
    elif [ -L "$full_path" ]; then
        echo -e "${RED}❌ Error: $file is a symlink (should be a real file)${NC}"

        # Try to find backup
        if [ -e "${full_path}.backup" ]; then
            echo -e "${YELLOW}   → Found backup at ${file}.backup${NC}"
            echo -e "${YELLOW}   → Run: rm $full_path && mv ${full_path}.backup $full_path${NC}"
        fi

        ERRORS=$((ERRORS + 1))
    else
        echo -e "${GREEN}✓ $file${NC}"
    fi
done

echo ""

if [ $ERRORS -eq 0 ]; then
    echo -e "${GREEN}✅ All validations passed! Ready to run install.sh${NC}"
    exit 0
else
    echo -e "${RED}❌ Found $ERRORS error(s). Please fix before running install.sh${NC}"
    exit 1
fi
