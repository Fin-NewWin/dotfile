return {
	{
		"ellisonleao/gruvbox.nvim",
		lazy = false,
		priority = 100,
		opts = {
			overrides = {
				GitSignsCurrentLineBlame = { link = "Comment" },
				["@lsp.type.function.lua"] = { link = "GruvboxOrange" },
				NormalFloat = { link = "Pmenu" },
				Pmenu = { bg = "#3c3836" },
				-- MiniCursorword = { bg = "#d7005f", fg = "#ffffff", bold = true, underline = true },
				MiniCursorwordCurrent = { underline = true },
				-- "semiSelected" for python
			},
			transparent_mode = true,
			-- contrast = "hard",
		},
		config = function(_, opts)
			require("gruvbox").setup(opts)
			vim.cmd.colorscheme("gruvbox")
		end,
	},
}
