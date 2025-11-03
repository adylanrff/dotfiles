return {
  "nvimtools/none-ls.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        -- Add additional code actions for Python
        null_ls.builtins.diagnostics.ruff,
        null_ls.builtins.formatting.black,
      },
    })
  end,
}
