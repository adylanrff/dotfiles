# dotfiles

<!--toc:start-->
- [dotfiles](#dotfiles)
  - [Installation](#installation)
<!--toc:end-->

This repository contains my personal dotfiles for configuring my development environment.
It includes tools like Vim,  tmux, Alacritty, and zsh.

## Installation

1. Pull this repository.

2. Just use symlinks to link the dotfiles to your configuration folders. For example, you can run the following commands:

```sh
ln -sf ~/path/to/dotfiles/nvim ~/.config/nvim
ln -sf ~/path/to/dotfiles/tmux/.tmux.conf ~/.tmux.conf
ln -sf ~/path/to/dotfiles/zsh/.zshrc ~/.zshrc
```

Make sure to replace `~/path/to/dotfiles/` with the actual path to your dotfiles directory.
