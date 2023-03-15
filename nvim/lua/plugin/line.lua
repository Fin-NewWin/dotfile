return {
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        config = true,
    },
    {
        "utilyre/barbecue.nvim",
        event = "VeryLazy",
        name = "barbecue",
        version = "*",
        dependencies = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            -- triggers CursorHold event faster
            vim.opt.updatetime = 200

            require("barbecue").setup {
                create_autocmd = false,
                attach_navic = false,
            }

            vim.api.nvim_create_autocmd({
                "WinResized",
                "BufWinEnter",
                "CursorHold",
                "InsertLeave",

                "BufWritePost",
                "TextChanged",
                "TextChangedI",
            }, {
                group = vim.api.nvim_create_augroup("barbecue.updater", {}),
                callback = function()
                    require("barbecue.ui").update()
                end,
            })
        end,
    },
}
