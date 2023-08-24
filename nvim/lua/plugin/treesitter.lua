return {
    "nvim-treesitter/nvim-treesitter",
    event = "BufReadPost",
    build = ":TSUpdate",
    dependencies = {
        "windwp/nvim-ts-autotag",
    },
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = "all",
            sync_install = false,
            auto_install = false,
            ignore_install = { "" },
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },

            autopairs = { enable = true },
            textobjects = { enable = true },

            autotag = { enable = true },
        })
    end,
}
