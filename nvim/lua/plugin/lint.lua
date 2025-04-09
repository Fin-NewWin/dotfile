return {
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			"rshkarin/mason-nvim-lint",
		},
		config = function()
			local lint = require("lint")

			lint.linters_by_ft = {
				javascript = { "eslint_d" },
				javascriptreact = { "eslint_d" },
				markdown = { "markdownlint" },
				python = { "flake8" },
				typescript = { "eslint_d" },
				typescriptreact = { "eslint_d" },
			}

			local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

			-- lint_opt.flake8.args = {
			-- 		"--ignore=E203",
			-- }

			vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter" }, {
				group = lint_augroup,
				callback = function()
					if vim.opt_local.modifiable:get() then
						lint.try_lint()
					end
				end,
			})

			require("mason-nvim-lint").setup()
		end,
	},
}
