# Neovim Configuration

A modern, feature-rich Neovim configuration for C/C++, Go, and Rust development.

## ✨ Features

### Core
- **Plugin Manager**: lazy.nvim
- **Package Manager**: Mason (LSP servers, formatters, debuggers)
- **Completion**: nvim-cmp with LSP, buffer, path, and snippet sources
- **Syntax**: Treesitter with C, C++, Go, Rust, Lua parsers

### Language Support
- **C/C++**: clangd LSP, clang-format, codelldb debugger
- **Go**: gopls LSP, goimports/gofmt, delve debugger
- **Rust**: rust-analyzer LSP, rustfmt, codelldb debugger
- **Lua**: stylua formatter

### UI & Navigation
- **File Explorer**: neo-tree
- **Fuzzy Finder**: Telescope with fzf-native
- **Quick Jump**: Flash.nvim for fast navigation
- **File Marks**: Harpoon for marking important files
- **Status Line**: lualine
- **Which-key**: Keybinding hints

### Git Integration
- **Signs**: gitsigns.nvim for inline git status
- **UI**: lazygit integration

### Editor Enhancements
- **Auto-formatting**: conform.nvim (format on save)
- **Auto-pairs**: nvim-autopairs
- **Surround**: mini.surround
- **Comments**: Comment.nvim
- **TODO Highlights**: todo-comments.nvim
- **Diagnostics**: Trouble.nvim
- **Indent Guides**: indent-blankline
- **Color Preview**: nvim-colorizer
- **Code Folding**: nvim-ufo with Treesitter
- **Word Highlight**: vim-illuminate
- **Better UI**: dressing.nvim

### Development Tools
- **Debugger**: nvim-dap with UI and virtual text
- **Terminal**: toggleterm (floating terminal)
- **Sessions**: persistence.nvim (auto-save sessions)
- **AI Assistant**: Claude Code integration

### Colorscheme
- **Theme**: Catppuccin (Mocha)

## 🚀 One-Command Installation

Works on **macOS**, **Arch Linux**, **Ubuntu/Debian**, and **Fedora**:

```bash
cd ~/Documents/Projects/dotfiles/nvim && ./install.sh
```

### What it does:
1. ✅ Detects your OS and distribution
2. ✅ Installs package manager (Homebrew on macOS)
3. ✅ Installs build tools (gcc, make, cmake)
4. ✅ Installs/updates Neovim (latest version)
5. ✅ Installs required tools (ripgrep, fd, fzf, lazygit)
6. ✅ Installs language toolchains (Go, Rust, Clang, Node.js)
7. ✅ Installs language servers and formatters
8. ✅ Creates symlink to `~/.config/nvim`
9. ✅ Bootstraps lazy.nvim
10. ✅ Installs all plugins
11. ✅ Configures Mason packages
12. ✅ Adds necessary PATH exports to shell config

### Manual Installation

If you prefer manual installation:

```bash
# 1. Clone or symlink this directory to ~/.config/nvim
ln -s ~/Documents/Projects/dotfiles/nvim ~/.config/nvim

# 2. Open Neovim (plugins will auto-install)
nvim

# 3. Install language servers
:MasonInstall clangd gopls rust-analyzer clang-format goimports stylua
```

## ⌨️ Keybindings

### Leader Key
- Leader: `<Space>`

### General
| Key | Action |
|-----|--------|
| `jk` / `jj` | Exit insert mode |
| `<C-h/j/k/l>` | Navigate between windows |
| `gl` | Show diagnostic message |
| `[d` / `]d` | Previous/next diagnostic |

### File Navigation
| Key | Action |
|-----|--------|
| `<Space>e` | Toggle file explorer |
| `<Space>ff` | Find files |
| `<Space>fg` | Live grep |
| `<Space>/` | Global search |
| `<Space>fb` | Find buffers |
| `<Space>fh` | Help tags |
| `<Space>ft` | Find TODOs |

### Flash (Quick Jump)
| Key | Action |
|-----|--------|
| `s` | Jump to any word |
| `S` | Jump to treesitter node |

### Harpoon (File Marks)
| Key | Action |
|-----|--------|
| `<Space>a` | Add file to harpoon |
| `<Space>hh` | Toggle harpoon menu |
| `<Space>1/2/3/4` | Jump to harpoon file 1-4 |

### LSP
| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `K` | Hover documentation |
| `gi` | Go to implementation |
| `gr` | Show references |
| `<Space>rn` | Rename symbol |
| `<Space>ca` | Code actions |

### Debugging
| Key | Action |
|-----|--------|
| `<Space>db` | Toggle breakpoint |
| `<Space>dc` | Continue/Start debugging |
| `<Space>di` | Step into |
| `<Space>do` | Step over |
| `<Space>dO` | Step out |
| `<Space>dr` | Open REPL |
| `<Space>dt` | Toggle DAP UI |
| `<Space>dl` | View DAP log |

### Git
| Key | Action |
|-----|--------|
| `<Space>gg` | Open LazyGit |

### Diagnostics/Errors
| Key | Action |
|-----|--------|
| `<Space>xx` | Toggle diagnostics (Trouble) |
| `<Space>xd` | Buffer diagnostics |
| `<Space>xl` | Location list |
| `<Space>xq` | Quickfix list |

### TODOs
| Key | Action |
|-----|--------|
| `]t` / `[t` | Next/previous TODO |

### Terminal
| Key | Action |
|-----|--------|
| `<Space>t` | Toggle floating terminal |
| `<Esc>` (in terminal) | Exit terminal mode |

### Sessions
| Key | Action |
|-----|--------|
| `<Space>qs` | Restore session |
| `<Space>ql` | Restore last session |
| `<Space>qd` | Don't save session |

### Claude Code
| Key | Action |
|-----|--------|
| `<Space>ac` | Toggle Claude Code |
| `<Space>af` | Focus Claude Code |
| `<Space>as` | Send to Claude Code |
| `<Space>aa` | Accept Claude diff |
| `<Space>ad` | Deny Claude diff |

### Code Folding
| Key | Action |
|-----|--------|
| `zR` | Open all folds |
| `zM` | Close all folds |
| `za` | Toggle fold |

## 📁 Structure

```
nvim/
├── init.lua                    # Entry point, basic settings
├── lua/
│   └── plugins/               # Plugin configurations (auto-loaded)
│       ├── cmp.lua            # Completion
│       ├── mason.lua          # LSP/tools management
│       ├── treesitter.lua     # Syntax highlighting
│       ├── telescope.lua      # Fuzzy finder
│       ├── neo-tree.lua       # File explorer
│       ├── dap.lua            # Debugging
│       ├── conform.lua        # Formatting
│       ├── gitsigns.lua       # Git integration
│       ├── lualine.lua        # Status line
│       ├── colorscheme.lua    # Theme
│       └── ...                # Other plugins
├── install.sh                 # One-command installer
└── README.md                  # This file
```

## 🔧 Requirements

- **Supported OS**: macOS, Arch Linux, Ubuntu/Debian, Fedora
  - Other Linux distributions may work but aren't tested
  - Manjaro and Pop!_OS are also supported
- Neovim >= 0.11.0 (auto-installed by script)
- Git (auto-installed by script)
- A Nerd Font (for icons) - [Download here](https://www.nerdfonts.com/)
- sudo access (for Linux package installation)

**Note**: If your distribution isn't supported, you can still manually install the requirements and use the manual installation method below.

## 🛠️ Customization

### Adding Language Support

1. Install LSP server via Mason: `:MasonInstall <server-name>`
2. Add to `lua/plugins/mason.lua` in the `ensure_installed` list
3. Configure in the `vim.lsp.config` section

### Changing Theme

Edit `lua/plugins/colorscheme.lua` and change the plugin or flavour.

### Adding Plugins

Create a new file in `lua/plugins/` with your plugin configuration:

```lua
return {
  "author/plugin-name",
  config = function()
    require("plugin-name").setup()
  end,
}
```

## 📝 Notes

- Auto-format on save is enabled for all configured languages
- Sessions are automatically saved per directory
- Lazy.nvim checks for plugin updates automatically
- Use `:checkhealth` to diagnose any issues

### Platform-Specific Notes

**Ubuntu/Debian:**
- `fd` is installed as `fd-find` and symlinked to `~/.local/bin/fd`
- Neovim is installed from the unstable PPA to get the latest version
- `lazygit` is installed from GitHub releases

**Arch Linux:**
- All packages installed from official repositories
- Uses `pacman` package manager

**Fedora:**
- `lazygit` installed from COPR repository
- Uses `dnf` package manager

**macOS:**
- Requires Homebrew package manager
- Xcode Command Line Tools needed for C/C++ development

## 🐛 Troubleshooting

### LSP not working
```vim
:LspInfo           " Check LSP status
:Mason             " Check installed servers
:checkhealth lsp   " Diagnose LSP issues
```

### Plugins not loading
```vim
:Lazy              " Check plugin status
:Lazy sync         " Sync/update plugins
```

### Debugger not working
```vim
:lua vim.print(vim.fn.stdpath('cache')..'/dap.log')  " View debug log
```

## 📚 Resources

- [Neovim Documentation](https://neovim.io/doc/)
- [lazy.nvim](https://github.com/folke/lazy.nvim)
- [Mason.nvim](https://github.com/williamboman/mason.nvim)
- [Telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
