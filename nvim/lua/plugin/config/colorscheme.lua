local status_ok, gruvbox = pcall(require, "gruvbox")
if not status_ok then
    return
end

gruvbox.setup({
    overrides = {

        NormalFloat     = {bg = "NONE"},
        SignColumn      = {bg = "NONE"},
        FloatBorder     = {TelescopeBorder},

        -- Git Colors
        GitSignsAdd     = {fg = "#b8bb26", bg = "NONE"},
        GitSignsChange  = {fg = "#fe8019", bg = "NONE"},
        GitSignsDelete  = {fg = "#fb4934", bg = "NONE"},

        -- LSP
        DiagnosticSignError =   { fg="#fb4934" },
        DiagnosticSignWarn  =   { fg="#fabd2f" },
        DiagnosticSignHint  =   { fg="#8ec07c" },
        DiagnosticSignInfo  =   { fg="#83a598" },

    }
})

local function colorscheme(name)
    vim.g.colors_name = name
    vim.o.background = vim.o.background
end

colorscheme('gruvbox')
