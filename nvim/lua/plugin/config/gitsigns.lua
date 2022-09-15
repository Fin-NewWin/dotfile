local status_ok, gitsigns = pcall(require, "gitsigns")
if not status_ok then
    return
end
return gitsigns.setup {
    signs = {
        add = {
            hl = "GitSignsAdd"   , text = "▍", numhl="GitSignsAddNr"   , linehl="GitSignsAddLn"
        },
        change = {
            hl = "GitSignsChange", text = "▍", numhl="GitSignsChangeNr", linehl="GitSignsChangeLn"
        },
        delete = {
            hl = "GitSignsDelete", text = "▍", numhl="GitSignsDeleteNr", linehl="GitSignsDeleteLn"
        },
        changedelete = {
            hl = "GitSignsChange", text = "▍", numhl="GitSignsChangeNr", linehl="GitSignsChangeLn"
        },
        topdelete = {
            hl = "GitSignsDelete", text = "‾", numhl="GitSignsDeleteNr", linehl="GitSignsDeleteLn"
        },
    },
    watch_gitdir = {
        interval = 1000,
        follow_files = true,
    },
    diff_opts = {
        algorithm = "histogram",
        internal = true,
        indent_heuristic = true,
    },
    sign_priority = 6,
}
