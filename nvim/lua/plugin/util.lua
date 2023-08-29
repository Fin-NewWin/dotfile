return {
    { "nvim-lua/plenary.nvim" },
    {
        "numToStr/Comment.nvim",
        event = "BufReadPost",
        opts = {
            ignore = "^$",
        },
        config = true,
    },
    {
        "ggandor/leap.nvim",
        event = "VeryLazy",
        dependencies = { { "ggandor/flit.nvim", opts = { labeled_modes = "nv" } } },
        config = function()
            require("leap").add_default_mappings()
        end,
    },
    {
        "Wansmer/treesj",
        keys = { "<space>m" },
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = function()
            require("treesj").setup({ use_default_keymaps = false })
            vim.keymap.set("n", "<leader>m", require("treesj").toggle)
        end,
    },
    {
        "cappyzawa/trim.nvim",
        event = "BufWrite",
        opts = {
            trim_on_write = true,
            trim_trailing = true,
            trim_last_line = false,
            trim_first_line = false,
        },
    },
    {
        "mbbill/undotree",
        keys = "<space>u",
        config = function()
            vim.keymap.set("n", "<space>u", vim.cmd.UndotreeToggle)
            vim.g.undotree_SplitWidth = 55
        end,
    },
}
