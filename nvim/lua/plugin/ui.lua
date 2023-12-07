return {
	{
		"luukvbaal/statuscol.nvim",
		event = "VeryLazy",
		config = function()
			local builtin = require("statuscol.builtin")
			require("statuscol").setup({
				ft_ignore = { "alpha", "neo-tree", "Trouble", "help" },
				bt_ignore = { "nofile" },
				segments = {
					{
						sign = {
							name = { "Diagnostic" },
							maxwidth = 1,
							colwidth = 2,
							auto = false,
							fillchar = " ",
						},
					},
					{
						text = {
							builtin.lnumfunc,
							" ",
						},
					},
					{
						sign = {
							namespace = { "gitsign*" },
							maxwidth = 1,
							colwidth = 1,
							auto = false,
							wrap = true,
							fillchar = " ",
							fillcharhl = "StatusColumnSeparator",
						},
					},
				},
			})
		end,
	},
	{
		"NvChad/nvim-colorizer.lua",
		event = "VeryLazy",
		config = true,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "VeryLazy",
		main = "ibl",
		opts = {
			scope = {
				enabled = false,
			},
		},
	},
	{
		"rcarriga/nvim-notify",
		opts = {
			-- on_open = function(win)
			-- 	vim.api.nvim_win_set_config(win, { zindex = 175 })
			-- 	if not vim.g.ui_notifications_enabled then
			-- 		vim.api.nvim_win_close(win, true)
			-- 	end
			-- 	if not package.loaded["nvim-treesitter"] then
			-- 		pcall(require, "nvim-treesitter")
			-- 	end
			-- 	vim.wo[win].conceallevel = 3
			-- 	local buf = vim.api.nvim_win_get_buf(win)
			-- 	if not pcall(vim.treesitter.start, buf, "markdown") then
			-- 		vim.bo[buf].syntax = "markdown"
			-- 	end
			-- 	vim.wo[win].spell = false
			-- end,
			timeout = 3000,
			background_colour = "#000000",
			max_height = function()
				return math.floor(vim.o.lines * 0.75)
			end,
			max_width = function()
				return math.floor(vim.o.columns * 0.75)
			end,
		},
		init = function()
			vim.notify = require("notify")
		end,
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		opts = {
			lsp = {
				progress = {
					enabled = false,
				},
				signature = {
					enabled = false,
					-- view = "hover",
				},
			},
			views = {
				mini = {
					win_options = {
						winblend = 0,
					},
				},
				popup = {
					win_options = {
						winhighlight = {
							Normal = "NormalFloat",
							NormalFloat = "NormalFloat",
						},
					},
				},
			},
		},
	},
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
		opts = {},
	},
}
