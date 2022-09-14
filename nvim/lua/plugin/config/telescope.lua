local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
    return
end

local tele_actions = require('telescope.actions')
local key = vim.api.nvim_set_keymap

telescope.setup{
    defaults = {
        prompt_prefix = " ",
        selection_caret = "ﰲ ",
        file_sorter = require("telescope.sorters").get_fzy_sorter,
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        path_display = { "truncate" },
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
        selection_strategy = "reset",
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
                ['<C-[>'] = tele_actions.close,
                ['<esc>'] = tele_actions.close,
                ['<C-c>'] = tele_actions.close,
                ['<C-u>'] = false,
                ['<C-d>'] = false,
            },

        },
        extensions = {
            fzy_native = {
                override_generic_sorter = true,
                override_file_sorter = true,
            }
        },
        color_devicons = true,
        set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
        winblend = 0,
        vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
            '--hidden',
        },
        file_ignore_patterns = { ".git/", "node_modules" },
    }
}
telescope.load_extension('fzy_native')

local opt = { noremap = true }

key('n', '<Leader>pf', '<cmd>lua require("telescope.builtin").find_files()<cr>', opt)
key('n', '<Leader>pg', '<cmd>noh<cr><cmd>lua require("telescope.builtin").live_grep()<cr>', opt)
key('n', '<Leader>pb', '<cmd>lua require("telescope.builtin").buffers()<cr>', opt)
key('n', '<Leader>ph', '<cmd>lua require("telescope.builtin").help_tags()<cr>', opt)
