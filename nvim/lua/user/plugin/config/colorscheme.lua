local status_ok, gruvbox = pcall(require, "gruvbox")
if not status_ok then
    return
end

local colors = require('gruvbox.palette')
-- vim.api.nvim_cmd()

gruvbox.setup({
    overrides = {

        NormalFloat     = {bg = "NONE"},
        TabLineFill = {bg = "NONE"},
        SignColumn      = {bg = "NONE"},
        FloatBorder     = {link = "TelescopeBorder" },

        Statusline = {bg = "#282828"},

        -- Git Colors
        GitSignsAdd     = {fg = colors.bright_green,    bg = "NONE"},
        GitSignsChange  = {fg = colors.bright_orange,   bg = "NONE"},
        GitSignsDelete  = {fg = colors.bright_red,      bg = "NONE"},

        -- LSP
        DiagnosticSignError =   {fg = colors.bright_red},
        DiagnosticSignWarn  =   {fg = colors.bright_yellow},
        DiagnosticSignHint  =   {fg = colors.bright_aqua},
        DiagnosticSignInfo  =   {fg = colors.bright_blue, bg = ""},

        -- navic
        NavicIconsFile          =   {link = "GruvboxBlue",          bold = 1},
        NavicIconsModule        =   {link = "GruvboxYellow",         bold = 1},
        NavicIconsNamespace     =   {link = "GruvboxYellow",         bold = 1},
        NavicIconsPackage       =   {link = "GruvboxBlue",      bold = 1},
        NavicIconsClass         =   {link = "GruvboxYellow",         bold = 1},
        NavicIconsMethod        =   {link = "GruvboxBlue",        bold = 1},
        NavicIconsProperty      =   {link = "GruvboxBlue",      bold = 1},
        NavicIconsField         =   {link = "GruvboxBlue",         bold = 1},
        NavicIconsConstructor   =   {link = "GruvboxYellow",   bold = 1},
        NavicIconsEnum          =   {link = "GruvboxOrange",         bold = 1},
        NavicIconsInterface     =   {link = "GruvboxYellow",     bold = 1},
        NavicIconsFunction      =   {link = "GruvboxBlue",      bold = 1},
        NavicIconsVariable      =   {link = "GruvboxOrange",      bold = 1, default = true},
        NavicIconsConstant      =   {link = "GruvboxOrange",      bold = 1},
        NavicIconsString        =   {link = "GruvboxOrange",          bold = 1},
        NavicIconsNumber        =   {link = "GruvboxOrange",         bold = 1},
        NavicIconsBoolean       =   {link = "GruvboxOrange",         bold = 1},
        NavicIconsArray         =   {link = "GruvboxOrange",      bold = 1},
        NavicIconsObject        =   {link = "GruvboxOrange",      bold = 1},
        NavicIconsKey           =   {link = "GruvboxPurple",       bold = 1},
        NavicIconsNull          =   {link = "GruvboxFg1",                   bold = 1},
        NavicIconsEnumMember    =   {link = "GruvboxOrange",      bold = 1},
        NavicIconsStruct        =   {link = "GruvboxYellow",        bold = 1},
        NavicIconsEvent         =   {link = "GruvboxOrange",         bold = 1},
        NavicIconsOperator      =   {link = "GruvboxOrange",      bold = 1},
        NavicIconsTypeParameter =   {link = "GruvboxYellow", bold = 1},

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

