return {
  -- add gruvbox
  {
    "folke/tokyonight.nvim",
    opts = {
      transparent = true,
    },
  },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight-moon",
    },
  },
}
