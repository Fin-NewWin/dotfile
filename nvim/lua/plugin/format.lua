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
        lazy = false,
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
            local mason_tool_installer = require("mason-tool-installer")

            local util = require("conform.util")
            util.add_formatter_args(require("conform.formatters.prettier"), { "--tab-width=4" })
            require("conform").setup(opts)

            -- TODO: wait for mason plugin for conform, for not workaround
            mason_tool_installer.setup({
                ensure_installed = vim.tbl_values(formatters_by_ft),
            })
        end,
    },
}
