local status_ok, gruvbox = pcall(require, "gruvbox")
if not status_ok then
    return
end

local colors = require('gruvbox.palette')
local api = vim.api

local ts = vim.treesitter

local default_map = {
    ["annotation"] = "TSAnnotation",
    ["attribute"] = "TSAttribute",
    ["boolean"] = "TSBoolean",
    ["character"] = "TSCharacter",
    ["character.special"] = "TSCharacterSpecial",
    ["comment"] = "TSComment",
    ["conditional"] = "TSConditional",
    ["constant"] = "TSConstant",
    ["constant.builtin"] = "TSConstBuiltin",
    ["constant.macro"] = "TSConstMacro",
    ["constructor"] = "TSConstructor",
    ["debug"] = "TSDebug",
    ["define"] = "TSDefine",
    ["error"] = "TSError",
    ["exception"] = "TSException",
    ["field"] = "TSField",
    ["float"] = "TSFloat",
    ["function"] = "TSFunction",
    ["function.call"] = "TSFunctionCall",
    ["function.builtin"] = "TSFuncBuiltin",
    ["function.macro"] = "TSFuncMacro",
    ["include"] = "TSInclude",
    ["keyword"] = "TSKeyword",
    ["keyword.function"] = "TSKeywordFunction",
    ["keyword.operator"] = "TSKeywordOperator",
    ["keyword.return"] = "TSKeywordReturn",
    ["label"] = "TSLabel",
    ["method"] = "TSMethod",
    ["method.call"] = "TSMethodCall",
    ["namespace"] = "TSNamespace",
    ["none"] = "TSNone",
    ["number"] = "TSNumber",
    ["operator"] = "TSOperator",
    ["parameter"] = "TSParameter",
    ["parameter.reference"] = "TSParameterReference",
    ["preproc"] = "TSPreProc",
    ["property"] = "TSProperty",
    ["punctuation.delimiter"] = "TSPunctDelimiter",
    ["punctuation.bracket"] = "TSPunctBracket",
    ["punctuation.special"] = "TSPunctSpecial",
    ["repeat"] = "TSRepeat",
    ["storageclass"] = "TSStorageClass",
    ["string"] = "TSString",
    ["string.regex"] = "TSStringRegex",
    ["string.escape"] = "TSStringEscape",
    ["string.special"] = "TSStringSpecial",
    ["symbol"] = "TSSymbol",
    ["tag"] = "TSTag",
    ["tag.attribute"] = "TSTagAttribute",
    ["tag.delimiter"] = "TSTagDelimiter",
    ["text"] = "TSText",
    ["text.strong"] = "TSStrong",
    ["text.emphasis"] = "TSEmphasis",
    ["text.underline"] = "TSUnderline",
    ["text.strike"] = "TSStrike",
    ["text.title"] = "TSTitle",
    ["text.literal"] = "TSLiteral",
    ["text.uri"] = "TSURI",
    ["text.math"] = "TSMath",
    ["text.reference"] = "TSTextReference",
    ["text.environment"] = "TSEnvironment",
    ["text.environment.name"] = "TSEnvironmentName",
    ["text.note"] = "TSNote",
    ["text.warning"] = "TSWarning",
    ["text.danger"] = "TSDanger",
    ["todo"] = "TSTodo",
    ["type"] = "TSType",
    ["type.builtin"] = "TSTypeBuiltin",
    ["type.qualifier"] = "TSTypeQualifier",
    ["type.definition"] = "TSTypeDefinition",
    ["variable"] = "TSVariable",
    ["variable.builtin"] = "TSVariableBuiltin",
}

-- compatibility shim
local link_captures
if ts.highlighter.hl_map then
    link_captures = function(capture, hlgroup)
        ts.highlighter.hl_map[capture] = hlgroup
    end
elseif not vim.g.skip_ts_default_groups then
    link_captures = function(capture, hlgroup)
        api.nvim_set_hl(0, "@" .. capture, { link = hlgroup, default = true })
    end
end

local function link_all_captures()
    if link_captures then
        for capture, hlgroup in pairs(default_map) do
            link_captures(capture, hlgroup)
        end
    end
end

link_all_captures()

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


        -- Treesitter current fixed
        TSNone = { default = true },
        TSPunctDelimiter = { link = "Delimiter", default = true },
        TSPunctBracket = { link = "Delimiter", default = true },
        TSPunctSpecial = { link = "Delimiter", default = true },
        TSConstant = { link = "Constant", default = true },
        TSConstBuiltin = { link = "Special", default = true },
        TSConstMacro = { link = "Define", default = true },
        TSString = { link = "String", default = true },
        TSStringRegex = { link = "String", default = true },
        TSStringEscape = { link = "SpecialChar", default = true },
        TSStringSpecial = { link = "SpecialChar", default = true },
        TSCharacter = { link = "Character", default = true },
        TSCharacterSpecial = { link = "SpecialChar", default = true },
        TSNumber = { link = "Number", default = true },
        TSBoolean = { link = "Boolean", default = true },
        TSFloat = { link = "Float", default = true },
        TSFunction = { link = "Function", default = true },
        TSFunctionCall = { link = "TSFunction", default = true },
        TSFuncBuiltin = { link = "Special", default = true },
        TSFuncMacro = { link = "Macro", default = true },
        TSParameter = { link = "Identifier", default = true },
        TSParameterReference = { link = "TSParameter", default = true },
        TSMethod = { link = "Function", default = true },
        TSMethodCall = { link = "TSMethod", default = true },
        TSField = { link = "Identifier", default = true },
        TSProperty = { link = "Identifier", default = true },
        TSConstructor = { link = "Special", default = true },
        TSAnnotation = { link = "PreProc", default = true },
        TSAttribute = { link = "PreProc", default = true },
        TSNamespace = { link = "Include", default = true },
        TSSymbol = { link = "Identifier", default = true },
        TSConditional = { link = "Conditional", default = true },
        TSRepeat = { link = "Repeat", default = true },
        TSLabel = { link = "Label", default = true },
        TSOperator = { link = "Operator", default = true },
        TSKeyword = { link = "Keyword", default = true },
        TSKeywordFunction = { link = "Keyword", default = true },
        TSKeywordOperator = { link = "TSOperator", default = true },
        TSKeywordReturn = { link = "TSKeyword", default = true },
        TSException = { link = "Exception", default = true },
        TSDebug = { link = "Debug", default = true },
        TSDefine = { link = "Define", default = true },
        TSPreProc = { link = "PreProc", default = true },
        TSStorageClass = { link = "StorageClass", default = true },
        TSTodo = { link = "Todo", default = true },
        TSType = { link = "Type", default = true },
        TSTypeBuiltin = { link = "Type", default = true },
        TSTypeQualifier = { link = "Type", default = true },
        TSTypeDefinition = { link = "Typedef", default = true },
        TSInclude = { link = "Include", default = true },
        TSVariableBuiltin = { link = "Special", default = true },
        TSText = { link = "TSNone", default = true },
        TSStrong = { bold = true, default = true },
        TSEmphasis = { italic = true, default = true },
        TSUnderline = { underline = true },
        TSStrike = { strikethrough = true },
        TSMath = { link = "Special", default = true },
        TSTextReference = { link = "Constant", default = true },
        TSEnvironment = { link = "Macro", default = true },
        TSEnvironmentName = { link = "Type", default = true },
        TSTitle = { link = "Title", default = true },
        TSLiteral = { link = "String", default = true },
        TSURI = { link = "Underlined", default = true },
        TSComment = { link = "Comment", default = true },
        TSNote = { link = "SpecialComment", default = true },
        TSWarning = { link = "Todo", default = true },
        TSDanger = { link = "WarningMsg", default = true },
        TSTag = { link = "Label", default = true },
        TSTagDelimiter = { link = "Delimiter", default = true },
        TSTagAttribute = { link = "TSProperty", default = true },
    },
    transparent_mode = true,
})

local function colorscheme(name)
    vim.g.colors_name = name
    vim.o.background = vim.o.background
end

colorscheme('gruvbox')
