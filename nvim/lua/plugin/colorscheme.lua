return {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 100,
    config = function()
        local ok, gruvbox = pcall(require, "gruvbox")
        if not ok then
            return
        end
        local theme = require("gruvbox.palette")
        gruvbox.setup({
            overrides = {

                NormalFloat = { bg = "NONE" },
                TabLineFill = { bg = "NONE" },
                SignColumn = { bg = "NONE" },

                FloatBorder = { link = "TelescopeBorder" },
                LspInfoBorder = { link = "FloatBorder" },

                WinBar = { bg = "NONE" },
                WinBarNC = { bg = "NONE" },
                IncSearch = { fg = "#fe8019", bg = "#ffffff" },
                CursorLineNr = { bg = "NONE" },

                -- Git Colors
                GitSignsAdd = { fg = theme.bright_green, bg = "NONE" },
                GitSignsChange = { fg = theme.bright_orange, bg = "NONE" },
                GitSignsDelete = { fg = theme.bright_red, bg = "NONE" },

                -- Navic
                NavicText = { link = "Comment" },
                NavicSeparator = { link = "Comment" },
            },
            transparent_mode = true,
            contrast = "hard",
            -- inverse = false,
        })
        vim.cmd.colorscheme("gruvbox")
    end,
}
