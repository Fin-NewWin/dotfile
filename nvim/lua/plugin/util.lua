return {
    { "nvim-lua/plenary.nvim" },
    {
        "lukas-reineke/indent-blankline.nvim",
        event = "BufReadPre",
        config = function()
            local status_ok, indent_blankline = pcall(require, "indent_blankline")
            if not status_ok then
                return
            end

            vim.opt.list = true
            vim.opt.listchars:append("eol:↴")
            indent_blankline.setup({
                use_treesitter = true,
                show_current_context = true,
                show_trailing_blankline_indent = false,
                filetype_exclude = {
                    "help",
                    "startify",
                    "dashboard",
                    "alpha",
                    "packer",
                    "NeogitStatus",
                    "NeogitCommitView",
                    "NeogitPopup",
                    "NeogitLogView",
                    "NeogitCommitMessage",
                    "man",
                    "sagasignature",
                    "sagahover",
                    "lspsagafinder",
                    "LspSagaCodeAction",
                    "TelescopePrompt",
                    "NvimTree",
                    "Trouble",
                    "DiffviewFiles",
                    "DiffviewFileHistory",
                    "Outline",
                    "lspinfo",
                    "fugitive",
                    "norg",
                },
                buftype_exclude = {
                    "terminal",
                    "nofile",
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
    {
        "numToStr/Comment.nvim",
        event = "BufReadPost",
        config = function()
            require("Comment").setup({
                ignore = "^$",
            })
        end,
    },
    {
        "rcarriga/nvim-notify",
        lazy = false,
        config = function()
            local status_ok, notify = pcall(require, "notify")
            if not status_ok then
                vim.notify("notify not in path", 4, { title = "Plugin Error" })
                return
            end
            notify.setup({
                background_colour = "#000000",
                timeout = 3000,
                level = 0,
                fps = 20,
                max_height = function()
                    return math.floor(vim.o.lines * 0.50)
                end,
                max_width = function()
                    return math.floor(vim.o.columns * 0.45)
                end,
                on_open = function(win)
                    vim.api.nvim_win_set_config(win, { focusable = false })
                    -- vim.api.nvim_set_option_value('statuscolumn', '', { win = win })
                end,
            })

            vim.notify = notify
        end,
    },
    {
        "ggandor/leap.nvim",
        event = "VeryLazy",
        dependencies = { { "ggandor/flit.nvim", opts = { labeled_modes = "nv" } } },
        config = function()
            require("leap").add_default_mappings()
        end,
    },
    {
        "atusy/tsnode-marker.nvim",
        filetype = "markdown",
        init = function()
            vim.api.nvim_create_autocmd("FileType", {
                group = vim.api.nvim_create_augroup("tsnode-marker-markdown", {}),
                pattern = "markdown",
                callback = function(ctx)
                    require("tsnode-marker").set_automark(ctx.buf, {
                        target = { "code_fence_content" }, -- list of target node types
                        hl_group = "CursorLine", -- highlight group
                    })
                end,
            })
        end,
    },
    {
        "Wansmer/treesj",
        keys = { "<space>m" },
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = function()
            require("treesj").setup({ use_default_keymaps = false })
            vim.keymap.set("n", "<leader>m", require("treesj").toggle)
        end,
    },
}
