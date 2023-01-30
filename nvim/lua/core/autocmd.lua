local au = vim.api.nvim_create_autocmd

-- Remove auto comments
au("Filetype", {
    pattern = "*",
    callback = function()
        vim.opt_local.formatoptions = "cqnjlr"
    end
})

-- Remove trailing white space
au("BufWritePre", { command = [[%s/\s\+$//e]] })

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
au('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})


au("FileType", { pattern = "yaml", command = "setlocal ts=4 sts=4 sw=4 expandtab" })

-- Enable spell checking for certain file types
au({ "BufRead", "BufNewFile" }, { pattern = { "*.txt", "*.md", "*.tex" }, command = "setlocal spell" })

-- show cursor line only in active window
au({ "InsertLeave", "WinEnter" }, {
    callback = function()
        local ok, cl = pcall(vim.api.nvim_win_get_var, 0, "auto-cursorline")
        if ok and cl then
            vim.wo.cursorline = true
            vim.api.nvim_win_del_var(0, "auto-cursorline")
        end
    end,
})
au({ "InsertEnter", "WinLeave" }, {
    callback = function()
        local cl = vim.wo.cursorline
        if cl then
            vim.api.nvim_win_set_var(0, "auto-cursorline", cl)
            vim.wo.cursorline = false
        end
    end,
})

-- Fix conceallevel for json & help files
au({ "FileType" }, {
    pattern = { "json", "jsonc" },
    callback = function()
        vim.wo.spell = false
        vim.wo.conceallevel = 0
    end,
})


-- Last place in file
au('BufReadPost', {
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- not really an autocmd
-- Remove hlsearch when not searching
local ns = vim.api.nvim_create_namespace('toggle_hlsearch')

local function toggle_hlsearch(char)
    if vim.fn.mode() == 'n' then
        local keys = { '<CR>', 'n', 'N', '*', '#', '?', '/' }
        local new_hlsearch = vim.tbl_contains(keys, vim.fn.keytrans(char))

        if vim.opt.hlsearch:get() ~= new_hlsearch then
            vim.opt.hlsearch = new_hlsearch
        end
    end
end

vim.on_key(toggle_hlsearch, ns)

-- close some filetypes with <q>
au("FileType", {
    pattern = {
        "qf",
        "help",
        "man",
        "notify",
        "lspinfo",
        "spectre_panel",
        "startuptime",
        "tsplayground",
        "PlenaryTestPopup",
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
    end,
})
