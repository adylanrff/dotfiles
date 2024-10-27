local map = vim.keymap.set

map({ "n", "x" }, "<leader>a", "<Plug>RustHoverAction")

vim.diagnostic.config({
  virtual_lines = false,
  virtual_text = false,
})
