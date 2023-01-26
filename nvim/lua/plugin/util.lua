return {
    { "nvim-lua/plenary.nvim" },
    {
        "lukas-reineke/indent-blankline.nvim",
        event = "BufReadPre",
        config = function()
            local status_ok, indent_blankline = pcall(require, "indent_blankline")
            if not status_ok then
                vim.notify("Indent Blankline not in path", 4, { title = "Plugin Error" })
                return
            end

            vim.opt.list = true
            vim.opt.listchars:append "eol:↴"
            indent_blankline.setup {
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
            }
        end
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

            colorizer.setup {
                filetypes = { "*", "!lazy" },
                buftype = { "*", "!prompt", "!nofile" },
                user_default_options = {
                    RGB = true, -- #RGB hex codes
                    RRGGBB = true, -- #RRGGBB hex codes
                    names = true, -- "Name" codes like Blue
                    RRGGBBAA = true, -- #RRGGBBAA hex codes
                    rgb_fn = true, -- CSS rgb() and rgba() functions
                    hsl_fn = true, -- CSS hsl() and hsla() functions
                    css = true, -- Enable all css features: rgb_fn, hsl_fn, names, RGB, RRGGBB
                    css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
                    mode = "background", -- Set the display mode
                    tailwind = true,
                },
            }
        end
    },
    {
        "numToStr/Comment.nvim",
        event = "BufReadPost",
        config = function()
            require('Comment').setup({
                ignore = '^$'
            })
        end
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
                end
            })

            vim.notify = notify
        end
    },
    {
        "ggandor/leap.nvim",
        event = "VeryLazy",
        dependencies = { { "ggandor/flit.nvim", opts = { labeled_modes = "nv" } } },
        config = true,
    },
    {
        "nyngwang/murmur.lua",
        event = "BufReadPre",
        config = function()
            local status_ok, murmur = pcall(require, "murmur")
            if not status_ok then
                vim.notify("murmur not in path", 4, { title = "Plugin Error" })
                return
            end
            murmur.setup {
                cursor_rgb = {
                    guibg = '#565656',
                },
                min_len = 2,
            }


            local group = "Murmur"
            vim.api.nvim_create_augroup(group, { clear = true })
            vim.api.nvim_create_autocmd("CursorHold", {
                group = group,
                pattern = '*',
                callback = function()

                    -- if vim.w.diag_shown then return end

                    if vim.w.cursor_word ~= '' then
                        vim.diagnostic.open_float(nil, {
                            focusable = false,
                            close_events = { "CursorMoved", "InsertEnter" },
                            border = "rounded",
                            source = "always",
                            scope = "cursor",
                        })
                        vim.w.diag_shown = true
                    end
                end
            })
        end
    },
}
