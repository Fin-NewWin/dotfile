return {
    {
        "anuvyklack/windows.nvim",
        config = true,
        event = "WinNew",
        dependencies = "anuvyklack/middleclass",
    },
    {
        "luukvbaal/statuscol.nvim",
        event = "VeryLazy",
        config = function()
            local builtin = require("statuscol.builtin")
            require("statuscol").setup({
                -- configuration goes here, for example:
                relculright = false,
                -- setopt = true,
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
}
