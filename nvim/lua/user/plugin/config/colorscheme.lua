local status_ok, gruvbox = pcall(require, "gruvbox")
if not status_ok then
    return
end

local theme = require('gruvbox.palette')
-- vim.api.nvim_cmd()

gruvbox.setup({
    overrides = {

        NormalFloat     = {bg = "NONE"},
        TabLineFill     = {bg = "NONE"},
        SignColumn      = {bg = "NONE"},
        FloatBorder     = {link = "TelescopeBorder" },

        Statusline = {bg = "#282828"},

        -- Git Colors
        GitSignsAdd     = {fg = theme.bright_green,    bg = "NONE"},
        GitSignsChange  = {fg = theme.bright_orange,   bg = "NONE"},
        GitSignsDelete  = {fg = theme.bright_red,      bg = "NONE"},

        -- LSP
        DiagnosticSignError =   {fg = theme.bright_red},
        DiagnosticSignWarn  =   {fg = theme.bright_yellow},
        DiagnosticSignHint  =   {fg = theme.bright_aqua},
        DiagnosticSignInfo  =   {fg = theme.bright_blue, bg = ""},

        -- LSP
        LspInfoBorder     = {link = "TelescopeBorder" },

    },
    transparent_mode = true,
    italic = false,
    contrast = "hard",
})

local function colorscheme(name)
    vim.g.colors_name = name
    vim.o.background = vim.o.background
end

colorscheme('gruvbox')
