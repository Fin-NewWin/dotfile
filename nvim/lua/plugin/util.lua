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
        "Wansmer/treesj",
        keys = { "<space>m" },
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = function()
            require("treesj").setup({ use_default_keymaps = false })
            vim.keymap.set("n", "<leader>m", require("treesj").toggle)
        end,
    },
    {
        "cappyzawa/trim.nvim",
        event = "BufWrite",
        opts = {
            trim_on_write = true,
            trim_trailing = true,
            trim_last_line = false,
            trim_first_line = false,
        },
    },
}
