return {
	{
		"echasnovski/mini.statusline",
		event = "BufRead",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"lewis6991/gitsigns.nvim",
		},
		opts = {
			set_vim_settings = false,
		},
		config = true,
	},
	{
		"echasnovski/mini.tabline",
		event = "BufRead",
		config = true,
	},
}
