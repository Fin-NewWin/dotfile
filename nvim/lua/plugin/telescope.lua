return {
    {
        "nvim-telescope/telescope.nvim",
        event = "BufEnter",
        cmd = { "Telescope" },
        dependencies = {
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            local telescope = require("telescope")
            local tele_actions = require("telescope.actions")
            local actions = require("telescope.actions")

            telescope.setup({
                defaults = {
                    prompt_prefix = "󰍉 ",
                    selection_caret = "󰜴 ",
                    sorting_strategy = "ascending",
                    layout_strategy = "horizontal",
                    layout_config = {
                        horizontal = {
                            prompt_position = "top",
                            preview_width = 0.55,
                            results_width = 0.8,
                        },
                        vertical = {
                            mirror = false,
                        },
                        width = 0.87,
                        height = 0.80,
                        preview_cutoff = 120,
                    },
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
