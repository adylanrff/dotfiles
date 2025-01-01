return {
  "yetone/avante.nvim",
  lazy = false,
  version = false, -- set this if you want to always pull the latest change
  enabled = true,
  opts = {
    provider = "openrouter",
    auto_suggestions_provider = "openrouter",
    vendors = {
      openrouter = {
        __inherited_from = "openai",
        api_key_name = "cmd:bw get password openrouter-api-key",
        endpoint = "https://openrouter.ai/api/v1",
        model = "deepseek/deepseek-chat",
      },
    },
    behaviour = {
      auto_suggestions = false, -- Experimental stage
      auto_apply_diff_after_generation = true,
    },

    mappings = {
      suggestion = {
        accept = "<M-l>",
      },
    },
  },

  dependencies = {
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    "zbirenbaum/copilot.lua", -- for providers='copilot'
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}
