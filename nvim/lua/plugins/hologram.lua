return {
  "edluffy/hologram.nvim",
  enabled = function()
    -- Only enable if ueberzugpp is available
    return vim.fn.executable("ueberzugpp") == 1
  end,
  config = function()
    require("hologram").setup({
      auto_display = true, -- Automatically display images in markdown
    })
  end,
}
