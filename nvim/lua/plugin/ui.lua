return {
	{
		"luukvbaal/statuscol.nvim",
		lazy = false,
		config = function()
			local builtin = require("statuscol.builtin")
			require("statuscol").setup({
				ft_ignore = { "alpha", "neo-tree", "Trouble", "help" },
				bt_ignore = { "nofile" },
				relculright = true,
				segments = {
					{
						sign = {
							namespace = { "diagnostic*" },
							fillchar = " ",
							fillcharhl = "StatusColumnSeparator",
							colwidth = 2,
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
		"lukas-reineke/indent-blankline.nvim",
		event = "VeryLazy",
		main = "ibl",
		opts = {
			indent = { char = "│" },
			scope = {
				enabled = false,
			},
		},
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},
}
