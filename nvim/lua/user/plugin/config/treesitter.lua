local M = {}

function M.config()
    require'nvim-treesitter.configs'.setup {
        ensure_installed = {
            "bash",
            "c",
            "cmake",
            "cpp",
            "css",
            "diff",
            "gitignore",
            "help",
            "html",
            "http",
            "java",
            "javascript",
            "jsdoc",
            "jsonc",
            "latex",
            "lua",
            "markdown",
            "markdown_inline",
            "meson",
            "ninja",
            "python",
            "regex",
            "rust",
            "scss",
            "sql",
            "teal",
            "toml",
            "tsx",
            "typescript",
            "vhs",
            "vim",
            "vue",
            "wgsl",
            "yaml",
            "json",
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
