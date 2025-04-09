return {
	{
		"echasnovski/mini.comment",
		event = "VeryLazy",
		dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
		opts = {
			options = {
				custom_commentstring = function()
					return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
				end,
				ignore_blank_line = true,
			},
		},
	},

	{
		"Wansmer/treesj",
		keys = { "<space>m" },
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("treesj").setup({ use_default_keymaps = false })
			vim.keymap.set("n", "<leader>m", require("treesj").toggle)
		end,
	},
	{
		"NvChad/nvim-colorizer.lua",
		event = "BufReadPost",
		opts = {
			filetypes = {
				"html",
				"css",
				"cssls",
				"scss",
				"less",
				"javascript",
				"typescript",
				"typescriptreact",
				"javascriptreact",
				"lua",
			},

			user_default_options = {
				tailwind = true, -- Enable tailwind colors
			},
		},
		config = true,
	},
}
