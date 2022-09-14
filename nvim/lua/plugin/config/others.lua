local M = {}

M.colorizer = function()
    local status_ok, colorizer = pcall(require, "colorizer")
    if not status_ok then
        return
    end

    colorizer.setup{
        filetypes = { "*" },
    }
end

M.lastplace = function()
    local status_ok, lastplace = pcall(require, "nvim-lastplace")
    if not status_ok then
        return
    end

    lastplace.setup {
        lastplace_ignore_buftype = {"quickfix", "nofile", "help"},
        lastplace_ignore_filetype = {"gitcommit", "gitrebase", "svn", "hgcommit"},
        lastplace_open_folds = true
    }
end

M.filetype = function()
    local status_ok, filetype = pcall(require, "filetype")
    if not status_ok then
        return
    end

    filetype.setup{}
end

M.gitsigns = function()
    local status_ok, gitsigns = pcall(require, "gitsigns")
    if not status_ok then
        return
    end
    gitsigns.setup {
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
end

return M
