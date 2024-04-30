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
				highlight = {
					additional_vim_regex_highlighting = false,
					enable = true,
					disable = function(lang, buf)
						local max_filesize = 100 * 1024 -- 100 KB
						local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
						return ok and stats and stats.size > max_filesize
						-- if ok and stats and stats.size > max_filesize then
						-- 	return true
						-- end
					end,
				},
				indent = {
					enable = true,
					disable = {
						"c",
						"cpp",
					},
				},
				autopairs = { enable = true },
				autotag = { enable = true },
			})
		end,
	},
}
