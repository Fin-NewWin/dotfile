return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = "BufReadPost",
		build = ":TSUpdate",
		dependencies = {
			"windwp/nvim-ts-autotag",
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = "all",
				sync_install = false,
				auto_install = true,
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				indent = {
					enable = true,
					-- FIX: not working with filetype nc which I translate to c in autocmd.lua
					-- remove when I need this to work on a c project with wrong indentation
					disable = { "c" },
				},
				autopairs = { enable = true },
				autotag = { enable = true },
			})
		end,
	},
}
