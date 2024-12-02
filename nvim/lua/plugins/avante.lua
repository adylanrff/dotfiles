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
        model = "qwen/qwen-2.5-coder-32b-instruct",
      },
    },
    behaviour = {
      auto_suggestions = true, -- Experimental stage
      auto_apply_diff_after_generation = true,
    },

    mappings = {
      suggestion = {
        accept = "<M-l>",
      },
    },
  },
}
