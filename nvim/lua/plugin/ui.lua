return {
    {
        "luukvbaal/statuscol.nvim",
        lazy = false,
        config = function()
            local builtin = require("statuscol.builtin")
            require("statuscol").setup({
                ft_ignore = { "alpha", "neo-tree", "Trouble", "help" },
                bt_ignore = { "nofile" },
                segments = {
                    {
                        sign = {
                            name = { "Diagnostic" },
                            maxwidth = 1,
                            colwidth = 2,
                            auto = false,
                            fillchar = " ",
                        },
                    },
                    {
                        text = {
                            builtin.lnumfunc,
                            " ",
                        },
                    },
                    {
                        sign = {
                            name = { "GitSigns" },
                            maxwidth = 1,
                            colwidth = 1,
                            auto = false,
                            wrap = true,
                            fillchar = " ",
                            fillcharhl = "StatusColumnSeparator",
                        },
                    },
                },
            })
        end,
    },
    {
        "NvChad/nvim-colorizer.lua",
        event = "BufReadPre",
        config = function()
            local status_ok, colorizer = pcall(require, "colorizer")
            if not status_ok then
                vim.notify("colorizer not in path", 4, { title = "Plugin Error" })
                return
            end

            colorizer.setup({
                filetypes = { "*", "!lazy" },
                buftype = { "*", "!prompt", "!nofile" },
                user_default_options = {
                    RGB = true, -- #RGB hex codes
                    RRGGBB = true, -- #RRGGBB hex codes
                    names = false, -- "Name" codes like Blue
                    RRGGBBAA = true, -- #RRGGBBAA hex codes
                    rgb_fn = true, -- CSS rgb() and rgba() functions
                    hsl_fn = true, -- CSS hsl() and hsla() functions
                    css = true, -- Enable all css features: rgb_fn, hsl_fn, names, RGB, RRGGBB
                    css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
                    mode = "background", -- Set the display mode
                    tailwind = true,
                },
            })
        end,
    },
}
