return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	config = true,
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
		},
		format_on_save = {
			timeout_ms = 1000,
		},
	},
}
