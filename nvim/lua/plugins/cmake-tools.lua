return {
  "Civitasv/cmake-tools.nvim",
  ft = { "cmake" },
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("cmake-tools").setup({
      cmake_build_directory = "build",
      cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON" },
    })
  end,
}
