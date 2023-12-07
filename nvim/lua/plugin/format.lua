local formatters_by_ft = {
	javascript = { "prettier" },
	typescript = { "prettier" },
	javascriptreact = { "prettier" },
	typescriptreact = { "prettier" },
	css = { "prettier" },
	html = { "prettier" },
	json = { "prettier" },
	lua = { "stylua" },
	python = { "black" },
}

return {
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		opts = {
			formatters_by_ft = formatters_by_ft,
			format_on_save = {
				lsp_fallback = false,
				async = true,
				timeout_ms = 500,
			},
		},
		config = function(_, opts)
			local util = require("conform.util")
			-- util.add_formatter_args(require("conform.formatters.prettierd"), { "--tab-width=2" })

			util.add_formatter_args(require("conform.formatters.prettier"), { "--single-quote", "--trailing-comma=none" })
			require("conform").setup(opts)

			local mason_tool_installer = require("mason-tool-installer")
			mason_tool_installer.setup({
				ensure_installed = vim.fn.uniq(vim.tbl_values(formatters_by_ft)),
			})
		end,
	},
}
