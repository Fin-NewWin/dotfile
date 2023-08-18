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
        opts = {
            ignore = "^$",
        },
        config = true,
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
