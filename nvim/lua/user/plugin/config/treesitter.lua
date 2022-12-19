local status_ok, treesitter = pcall(require, "nvim-treesitter.configs")
if not status_ok then
    return
end

treesitter.setup {
    ensure_installed = "all",
    sync_install = true,
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
