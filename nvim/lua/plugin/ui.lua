return {
    {
        "luukvbaal/statuscol.nvim",
        event = "VeryLazy",
        config = function()
            local builtin = require("statuscol.builtin")
            require("statuscol").setup({
                ft_ignore = { "alpha", "neo-tree", "Trouble", "help" },
                bt_ignore = { "nofile" },
                segments = {
                    {
                        sign = {
                            name = { "Diagnostic" },
                            maxwidth = 1,
                            colwidth = 2,
                            auto = false,
                            fillchar = " ",
                        },
                    },
                    {
                        text = {
                            builtin.lnumfunc,
                            " ",
                        },
                    },
                    {
                        sign = {
                            name = { "GitSigns" },
                            maxwidth = 1,
                            colwidth = 1,
                            auto = false,
                            wrap = true,
                            fillchar = " ",
                            fillcharhl = "StatusColumnSeparator",
                        },
                    },
                },
            })
        end,
    },
    {
        "akinsho/toggleterm.nvim",
        event = "VeryLazy",
        opts = {
            size = 20,
            on_create = function()
                vim.opt.foldcolumn = "0"
                vim.opt.signcolumn = "no"
            end,
            open_mapping = [[<F7>]],
            direction = "horizontal",
        },
    },
    {
        "NvChad/nvim-colorizer.lua",
        event = { "BufReadPre", "BufNewFile" },
        config = true,
    },
}
