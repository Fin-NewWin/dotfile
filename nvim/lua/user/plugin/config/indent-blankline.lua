local M = {}

function M.config()
    local status_ok, indent_blankline = pcall(require, "indent_blankline")
    if not status_ok then
        return
    end

    vim.opt.list = true
    vim.opt.listchars:append "eol:↴"
    indent_blankline.setup {
        show_current_context = true,
        filetype_exclude = {
            "help",
            "startify",
            "dashboard",
            "alpha",
            "packer",
            "NeogitStatus",
            "NeogitCommitView",
            "NeogitPopup",
            "NeogitLogView",
            "NeogitCommitMessage",
            "man",
            "sagasignature",
            "sagahover",
            "lspsagafinder",
            "LspSagaCodeAction",
            "TelescopePrompt",
            "NvimTree",
            "Trouble",
            "DiffviewFiles",
            "DiffviewFileHistory",
            "Outline",
            "lspinfo",
            "fugitive",
            "norg",
        },
        buftype_exclude = {
            "terminal",
            "nofile",
        },
    }
end

return M
