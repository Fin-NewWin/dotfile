local M = {}

function M.config()
    local ok, gruvbox = pcall(require, "gruvbox")
    if not ok then
        vim.notify("Gruvbox not installed", "error", {title = "Plugin config error"})
        return
    end
    local theme = require("gruvbox.palette")
    gruvbox.setup({
        overrides = {

            NormalFloat     = {bg = "NONE"},
            TabLineFill     = {bg = "NONE"},
            SignColumn      = {bg = "NONE"},
            FloatBorder     = {link = "TelescopeBorder" },
            WinBar          = {bg = "NONE"},
            WinBarNC        = {bg = "NONE"},
            IncSearch       = {fg="#fe8019", bg="#ffffff"},

            -- Git Colors
            GitSignsAdd     = {fg = theme.bright_green,    bg = "NONE"},
            GitSignsChange  = {fg = theme.bright_orange,   bg = "NONE"},
            GitSignsDelete  = {fg = theme.bright_red,      bg = "NONE"},

            -- LSP
            DiagnosticSignError =   {fg = theme.bright_red},
            DiagnosticSignWarn  =   {fg = theme.bright_yellow},
            DiagnosticSignHint  =   {fg = theme.bright_aqua},
            DiagnosticSignInfo  =   {fg = theme.bright_blue, bg = "NONE"},
            LspInfoBorder     = {link = "TelescopeBorder" },

            -- Navic
            NavicText = {link = "Comment"},
            NavicSeparator = {link = "Comment"},

        },
        transparent_mode = true,
        italic = false,
        contrast = "hard",
        -- inverse = false,
    })
    vim.cmd.colorscheme("gruvbox")
end

return M
