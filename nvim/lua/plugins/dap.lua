return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"theHamsta/nvim-dap-virtual-text",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			-- Setup UI
			dapui.setup()

			-- Setup virtual text
			require("nvim-dap-virtual-text").setup()

			-- Go (delve) configuration
			dap.adapters.delve = {
				type = "server",
				port = "${port}",
				executable = {
					command = "dlv",
					args = { "dap", "-l", "127.0.0.1:${port}" },
				},
			}

			dap.configurations.go = {
				{
					type = "delve",
					name = "Debug",
					request = "launch",
					program = "${file}",
				},
				{
					type = "delve",
					name = "Debug (with args)",
					request = "launch",
					program = "${file}",
					args = function()
						local args_string = vim.fn.input("Arguments: ")
						return vim.split(args_string, " ")
					end,
				},
				{
					type = "delve",
					name = "Debug test",
					request = "launch",
					mode = "test",
					program = "${file}",
				},
				{
					type = "delve",
					name = "Debug package",
					request = "launch",
					program = "${fileDirname}",
				},
			}

			-- Python (debugpy) configuration
			dap.adapters.python = {
				type = "executable",
				command = "python",
				args = { "-m", "debugpy.adapter" },
			}

			dap.configurations.python = {
				{
					type = "python",
					request = "launch",
					name = "Debug",
					program = "${file}",
					pythonPath = function()
						return "python"
					end,
				},
				{
					type = "python",
					request = "launch",
					name = "Debug (with args)",
					program = "${file}",
					pythonPath = function()
						return "python"
					end,
					args = function()
						local args_string = vim.fn.input("Arguments: ")
						return vim.split(args_string, " ")
					end,
				},
			}

			-- Auto open/close UI
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end

			-- Enable verbose logging
			dap.set_log_level("TRACE")

			-- Keybindings
			vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
			vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue" })
			vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step into" })
			vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Step over" })
			vim.keymap.set("n", "<leader>dO", dap.step_out, { desc = "Step out" })
			vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "Open REPL" })
			vim.keymap.set("n", "<leader>dt", dapui.toggle, { desc = "Toggle DAP UI" })
			vim.keymap.set("n", "<leader>dA", function()
				local args_string = vim.fn.input("Arguments: ")
				local args = vim.split(args_string, " ")
				local ft = vim.bo.filetype
				if ft == "go" then
					dap.run({
						type = "delve",
						name = "Debug with args",
						request = "launch",
						program = "${file}",
						args = args,
					})
				elseif ft == "python" then
					dap.run({
						type = "python",
						name = "Debug with args",
						request = "launch",
						program = "${file}",
						pythonPath = "python",
						args = args,
					})
				else
					vim.notify("No debug configuration for filetype: " .. ft, vim.log.levels.WARN)
				end
			end, { desc = "Debug with args" })
			vim.keymap.set("n", "<leader>dl", function()
				vim.cmd("edit " .. vim.fn.stdpath("cache") .. "/dap.log")
			end, { desc = "Open DAP log" })
		end,
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap" },
		config = function()
			require("mason-nvim-dap").setup({
				ensure_installed = {
					"codelldb", -- C/C++/Rust
					"delve", -- Go
					"debugpy", -- Python
				},
				automatic_installation = true,
				handlers = {},
			})
		end,
	},
}
