return {
    "nvim-treesitter/nvim-treesitter",
    event = "BufReadPost",
    build = ":TSUpdate",
    dependencies = {
        "JoosepAlviste/nvim-ts-context-commentstring",
        "windwp/nvim-ts-autotag",
        "HiPhish/nvim-ts-rainbow2",
    },
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = "all",
            sync_install = false,
            auto_install = false,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
                disable = function(lang, buf)
                    local max_filesize = 100 * 1024 -- 100 KB
                    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                    if ok and stats and stats.size > max_filesize then
                        return true
                    end
                end,
            },

            autopairs = { enable = true },
            indent = { enable = false },
            rainbow = {
                enable = true,
                query = "rainbow-parens",
                strategy = require("ts-rainbow").strategy.global,
            },

            autotag = { enable = true },
            context_commentstring = { enable = true, enable_autocmd = false },
            disable = function(_, buf)
                local max_filesize = 100 * 1024 -- 100 KB
                local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                if ok and stats and stats.size > max_filesize then
                    return true
                end
            end,
        })
    end,
}
