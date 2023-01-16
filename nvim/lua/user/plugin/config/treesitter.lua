local M = {}

function M.config()
    require 'nvim-treesitter.configs'.setup {
        ensure_installed = "all",
        sync_install = false,
        auto_install = false,
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
            use_languagetree = true,
        },
        context_commentstring = { enable = true, enable_autocmd = false },
        autopairs = { enable = true, },
        indent = { enable = false, },
        autotag = { enable = true, },
    }
end

return M
