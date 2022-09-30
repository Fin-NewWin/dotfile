local status_ok, gruvbox = pcall(require, "gruvbox")
if not status_ok then
    return
end

local colors = require('gruvbox.palette')

gruvbox.setup({
    overrides = {

        NormalFloat     = {bg = "NONE"},
        SignColumn      = {bg = "NONE"},
        FloatBorder     = {link = "TelescopeBorder" },

        -- Git Colors
        GitSignsAdd     = {fg = colors.bright_green,    bg = "NONE"},
        GitSignsChange  = {fg = colors.bright_orange,   bg = "NONE"},
        GitSignsDelete  = {fg = colors.bright_red,      bg = "NONE"},

        -- LSP
        DiagnosticSignError =   {fg = colors.bright_red},
        DiagnosticSignWarn  =   {fg = colors.bright_yellow},
        DiagnosticSignHint  =   {fg = colors.bright_aqua},
        DiagnosticSignInfo  =   {fg = colors.bright_blue},

        -- navic
        NavicIconsFile          =   {link = "CmpItemKindFile",          bold = 1},
        NavicIconsModule        =   {link = "CmpItemKindClass",         bold = 1},
        NavicIconsNamespace     =   {link = "CmpItemKindClass",         bold = 1},
        NavicIconsPackage       =   {link = "CmpItemKindProperty",      bold = 1},
        NavicIconsClass         =   {link = "CmpItemKindClass",         bold = 1},
        NavicIconsMethod        =   {link = "CmpItemKindMethod",        bold = 1},
        NavicIconsProperty      =   {link = "CmpItemKindProperty",      bold = 1},
        NavicIconsField         =   {link = "CmpItemKindField",         bold = 1},
        NavicIconsConstructor   =   {link = "CmpItemKindConstructor",   bold = 1},
        NavicIconsEnum          =   {link = "CmpItemKindValue",         bold = 1},
        NavicIconsInterface     =   {link = "CmpItemKindInterface",     bold = 1},
        NavicIconsFunction      =   {link = "CmpItemKindFunction",      bold = 1},
        NavicIconsVariable      =   {link = "CmpItemKindVariable",      bold = 1, default = true},
        NavicIconsConstant      =   {link = "CmpItemKindVariable",      bold = 1},
        NavicIconsString        =   {link = "CmpItemKindText",          bold = 1},
        NavicIconsNumber        =   {link = "CmpItemKindValue",         bold = 1},
        NavicIconsBoolean       =   {link = "CmpItemKindValue",         bold = 1},
        NavicIconsArray         =   {link = "CmpItemKindVariable",      bold = 1},
        NavicIconsObject        =   {link = "CmpItemKindVariable",      bold = 1},
        NavicIconsKey           =   {link = "CmpItemKindKeyword",       bold = 1},
        NavicIconsNull          =   {link = "TSNone",                   bold = 1},
        NavicIconsEnumMember    =   {link = "CmpItemKindVariable",      bold = 1},
        NavicIconsStruct        =   {link = "CmpItemKindStruct",        bold = 1},
        NavicIconsEvent         =   {link = "CmpItemKindEvent",         bold = 1},
        NavicIconsOperator      =   {link = "CmpItemKindOperator",      bold = 1},
        NavicIconsTypeParameter =   {link = "CmpItemKindTypeParameter", bold = 1},
    },
    transparent_mode = true,
})

local function colorscheme(name)
    vim.g.colors_name = name
    vim.o.background = vim.o.background
end

colorscheme('gruvbox')
