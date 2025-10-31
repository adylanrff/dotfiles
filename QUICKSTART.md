# Quick Start Guide

## Installation

```bash
git clone <your-repo> ~/Documents/Projects/dotfiles
cd ~/Documents/Projects/dotfiles
./install.sh
```

## Essential Shortcuts

### Tmux (Prefix: `Ctrl+a`)
```
Ctrl+a c         New window
Ctrl+a |         Split vertical
Ctrl+a -         Split horizontal
Ctrl+a arrows    Switch panes
Ctrl+a d         Detach session
Ctrl+a [         Scroll mode (q to exit)
Ctrl+a I         Install plugins
Ctrl+a r         Reload config
```

### Neovim (Leader: `Space`)

**Files:**
```
Space e          File explorer
Space ff         Find files
Space /          Search text
Space fb         Find buffers
```

**Navigation:**
```
s                Jump to word (flash)
Ctrl+h/j/k/l     Switch windows
Space 1/2/3/4    Harpoon marks
Space hh         Harpoon menu
```

**Code:**
```
gd               Go to definition
K                Hover docs
gr               References
Space rn         Rename
Space ca         Code actions
gl               Show diagnostic
[d / ]d          Prev/next diagnostic
```

**Git:**
```
Space gg         LazyGit
```

**Debug:**
```
Space db         Toggle breakpoint
Space dc         Start/Continue
Space di         Step into
Space do         Step over
```

**Terminal:**
```
Space t          Toggle terminal
jk or jj         Exit insert mode
```

### Zsh
```
→                Accept suggestion
Tab              Complete
Ctrl+r           Search history
alias            Show all aliases
```

## First Time Setup

1. **Restart terminal** after installation
2. **Log out and back in** to activate Zsh
3. Open **Alacritty** as your new terminal
4. Start **tmux**: `tmux`
5. Install tmux plugins: `Ctrl+a I`
6. Open **nvim** - plugins auto-install
7. Done!

## Common Tasks

**Update everything:**
```bash
cd ~/Documents/Projects/dotfiles
git pull
./install.sh
```

**Update Neovim plugins:**
```
nvim
:Lazy sync
```

**Check Neovim health:**
```
nvim
:checkhealth
```

**Reload configs:**
```bash
source ~/.zshrc          # Zsh
tmux source ~/.tmux.conf # Tmux (or Ctrl+a r)
```

## Troubleshooting

**Neovim LSP not working:**
```
:LspInfo    # Check status
:Mason      # Install servers
```

**Tmux plugins not loading:**
```
# In tmux: Ctrl+a I
```

**Zsh not default:**
```bash
chsh -s $(which zsh)
# Log out and back in
```

## File Locations

```
~/.zshrc                         # Zsh config
~/.tmux.conf                     # Tmux config
~/.config/nvim/                  # Neovim config
~/.config/alacritty/alacritty.toml  # Alacritty config
~/.local/bin/                    # Custom scripts
```

All are symlinks to `~/Documents/Projects/dotfiles/`
