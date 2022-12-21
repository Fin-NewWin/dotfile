local M = {}

function M.config()
    require'nvim-treesitter.configs'.setup {
        ensure_installed = {
            "lua",
            "latex",
        },
        sync_install = false,
        auto_install = false,
        context_commentstring = { enable = true, enable_autocmd = false },
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
            use_languagetree = true,
        },
        autopairs = {
            enable = true,
        },
        indent = {
            enable = false,
        },
        autotag = {
            enable = true,
        },
    }
end

return M
