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
            -- WinBar          = {bg = "NONE"},

            Statusline = {bg = "#282828"},
            Search = {fg = "#1d2021", bg = "#fabd2f" },

            -- Git Colors
            GitSignsAdd     = {fg = theme.bright_green,    bg = "NONE"},
            GitSignsChange  = {fg = theme.bright_orange,   bg = "NONE"},
            GitSignsDelete  = {fg = theme.bright_red,      bg = "NONE"},

            -- LSP
            DiagnosticSignError =   {fg = theme.bright_red},
            DiagnosticSignWarn  =   {fg = theme.bright_yellow},
            DiagnosticSignHint  =   {fg = theme.bright_aqua},
            DiagnosticSignInfo  =   {fg = theme.bright_blue, bg = "NONE"},

            -- LSP
            LspInfoBorder     = {link = "TelescopeBorder" },

        },
        transparent_mode = true,
        italic = false,
        contrast = "hard",
        inverse = false,
    })
    vim.cmd.colorscheme("gruvbox")
end

return M
