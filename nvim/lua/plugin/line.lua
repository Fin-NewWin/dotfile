return {
	{
		"echasnovski/mini.statusline",
		event = "BufRead",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"lewis6991/gitsigns.nvim",
		},
		config = true,
	},
	{
		"echasnovski/mini.tabline",
		event = "BufRead",
		config = true,
	},
}
