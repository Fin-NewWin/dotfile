return {
    "nvim-treesitter/nvim-treesitter",
    event = "BufReadPost",
    build = ":TSUpdate",
    dependencies = {
        { "JoosepAlviste/nvim-ts-context-commentstring" },
        { "windwp/nvim-ts-autotag" },
    },
    config = function()
        require('nvim-treesitter.configs').setup {
            ensure_installed = "all",
            sync_install = false,
            auto_install = false,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            autopairs = { enable = true, },
            indent = { enable = false, },

            autotag = { enable = true, },
            context_commentstring = { enable = true, enable_autocmd = false },
        }
    end
}
