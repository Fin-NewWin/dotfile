return {
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        config = true,
    },
    {
        "utilyre/barbecue.nvim",
        -- event = "BufEnter",
        lazy = false,
        name = "barbecue",
        version = "*",
        dependencies = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("barbecue").setup({
                attach_navic = false,
                opts = {
                    exclude_filetypes = { "gitcommit", "Trouble", "toggleterm" },
                    show_modified = false,
                },
            })
        end,
    },
}
