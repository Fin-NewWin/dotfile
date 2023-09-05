return {
    {
        "nvim-telescope/telescope.nvim",
        event = "BufEnter",
        cmd = { "Telescope" },
        dependencies = {
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        },
        config = function()
            local telescope = require("telescope")
            local tele_actions = require("telescope.actions")
            local actions = require("telescope.actions")

            telescope.setup({
                defaults = {
                    sorting_strategy = "ascending",
                    layout_strategy = "horizontal",
                    mappings = {
                        i = {
                            ["<C-[>"] = tele_actions.close,
                            ["<esc>"] = tele_actions.close,
                            ["<C-c>"] = tele_actions.close,
                            ["<C-u>"] = false,
                            ["<C-d>"] = false,
                            ["<C-h>"] = actions.select_horizontal,
                            ["<C-v>"] = actions.select_vertical,
                        },
                    },
                },
            })

            pcall(require("telescope").load_extension, "fzf")

            local key = vim.keymap.set
            local opt = { noremap = true }
            local builtin = require("telescope.builtin")

            key("n", "<Leader>pf", builtin.find_files, opt)
            key("n", "<Leader>pd", builtin.diagnostics, opt)
            key("n", "<Leader>pg", builtin.live_grep, opt)
        end,
    },
}
