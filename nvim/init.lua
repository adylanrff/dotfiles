-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Ensure space works normally in insert mode
vim.keymap.set("i", " ", " ", { noremap = true })

-- Options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"  -- Use system clipboard for yank/paste
vim.opt.signcolumn = "auto:2"
vim.opt.timeoutlen = 300  -- Time in ms to wait for a mapped sequence to complete

-- Tab settings
vim.opt.tabstop = 2        -- Number of spaces tabs count for
vim.opt.shiftwidth = 2     -- Size of an indent
vim.opt.expandtab = true   -- Use spaces instead of tabs
vim.opt.softtabstop = 2    -- Number of spaces tabs count for in insert mode

-- Diagnostic signs
vim.fn.sign_define("DiagnosticSignError", { text = "●", texthl = "DiagnosticSignError", priority = 10 })
vim.fn.sign_define("DiagnosticSignWarn", { text = "●", texthl = "DiagnosticSignWarn", priority = 10 })
vim.fn.sign_define("DiagnosticSignInfo", { text = "●", texthl = "DiagnosticSignInfo", priority = 10 })
vim.fn.sign_define("DiagnosticSignHint", { text = "●", texthl = "DiagnosticSignHint", priority = 10 })

-- Breakpoint signs
vim.fn.sign_define(
	"DapBreakpoint",
	{ text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
)
vim.fn.sign_define(
	"DapBreakpointCondition",
	{ text = "ﳁ", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
)
vim.fn.sign_define(
	"DapBreakpointRejected",
	{ text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
)
vim.fn.sign_define(
	"DapLogPoint",
	{ text = "", texthl = "DapLogPoint", linehl = "DapLogPoint", numhl = "DapLogPoint" }
)
vim.fn.sign_define("DapStopped", { text = "", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" })

--
-- Diagnostic keybindings
vim.keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "Show diagnostic" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })

-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })

-- Python: Create function stub from current word
vim.keymap.set("n", "<leader>cf", function()
  local word = vim.fn.expand("<cword>")
  local lines = {
    "",
    "",
    "def " .. word .. "():",
    '    """TODO: Implement ' .. word .. '"""',
    "    pass",
  }
  vim.api.nvim_buf_set_lines(0, -1, -1, false, lines)
  vim.cmd("normal! G")
end, { desc = "Create function stub" })

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		{ import = "plugins" },
	},
	checker = { enabled = true },
})
