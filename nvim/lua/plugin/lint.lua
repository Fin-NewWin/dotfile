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
                typescript = { "eslint_d" },
                javascriptreact = { "eslint_d" },
                typescriptreact = { "eslint_d" },
                python = { "pylint" },
                sh = { "shellcheck" },
            }

            local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

            local lint_opt = require('lint').linters

            lint_opt.shellcheck.args = {
                args = {
                    "-x"
                }
            }

            vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
                group = lint_augroup,
                callback = function()
                    lint.try_lint()
                end,
            })

            require("mason-nvim-lint").setup()
        end,
    },
}
