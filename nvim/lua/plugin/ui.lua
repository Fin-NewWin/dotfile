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
		"stevearc/dressing.nvim",
		event = "VeryLazy",
		opts = {},
	},
}
