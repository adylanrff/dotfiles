return {
  "echasnovski/mini.hipatterns",
  recommended = true,
  desc = "Highlight colors in your code. Also includes Tailwind CSS support.",
  event = "LazyFile",
  opts = function()
    local hi = require("mini.hipatterns")
    return {
      highlighters = {
        hex_color = hi.gen_highlighter.hex_color({ priority = 2000 }),
      },
    }
  end,
}
