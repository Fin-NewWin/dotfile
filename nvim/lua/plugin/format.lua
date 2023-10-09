return {
    {
        "stevearc/conform.nvim",
        lazy = false,
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            formatters_by_ft = {
                javascript = { "prettier" },
                typescript = { "prettier" },
                lua = { "stylua" },
            },
            format_on_save = {
                lsp_fallback = false,
                async = true,
                timeout_ms = 500,
            },
        },
        config = function(_, opts)
            local util = require("conform.util")
            util.add_formatter_args(require("conform.formatters.prettier"), { "--tab-width=4" })
            require("conform").setup(opts)
        end,
    },
}
