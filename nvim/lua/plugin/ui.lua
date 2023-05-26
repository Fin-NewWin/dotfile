return {
    {
        "anuvyklack/windows.nvim",
        config = true,
        event = "WinNew",
        dependencies = {
            "anuvyklack/middleclass",
        },
    },
    {
        "luukvbaal/statuscol.nvim",
        lazy = false,
        config = function()
            local builtin = require("statuscol.builtin")
            require("statuscol").setup({
                -- relculright = false,

                ft_ignore = { "alpha", "neo-tree", "Trouble", "help" },
                bt_ignore = { "nofile" },
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
