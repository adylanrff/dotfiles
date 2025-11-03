return {
  "ThePrimeagen/refactoring.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("refactoring").setup({
      prompt_func_return_type = {
        go = false,
        java = false,
        cpp = false,
        c = false,
        h = false,
        hpp = false,
        cxx = false,
        python = true,
      },
      prompt_func_param_type = {
        go = false,
        java = false,
        cpp = false,
        c = false,
        h = false,
        hpp = false,
        cxx = false,
        python = true,
      },
    })

    -- Keybindings for refactoring
    vim.keymap.set("x", "<leader>re", ":Refactor extract ", { desc = "Extract function" })
    vim.keymap.set("x", "<leader>rf", ":Refactor extract_to_file ", { desc = "Extract to file" })
    vim.keymap.set("x", "<leader>rv", ":Refactor extract_var ", { desc = "Extract variable" })
    vim.keymap.set({ "n", "x" }, "<leader>ri", ":Refactor inline_var", { desc = "Inline variable" })
    vim.keymap.set("n", "<leader>rI", ":Refactor inline_func", { desc = "Inline function" })
    vim.keymap.set("n", "<leader>rb", ":Refactor extract_block", { desc = "Extract block" })
    vim.keymap.set("n", "<leader>rbf", ":Refactor extract_block_to_file", { desc = "Extract block to file" })
  end,
}
