local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

autocmd("BufEnter", {
    desc = "Remove auto comments",
    pattern = "*",
    callback = function()
        vim.opt.formatoptions:remove({ "c", "r", "o" })
    end,
})

autocmd("TermOpen", {
    desc = "Terminal settings",
    callback = function()
        vim.opt_local.relativenumber = false
        vim.opt_local.number = false
        vim.cmd("startinsert!")
    end,
})

autocmd({ "BufLeave", "FocusLost" }, {
    desc = "Autosave when neovim not focused or when leaving buffer",
    callback = function()
        if vim.bo.modified and not vim.bo.readonly and vim.fn.expand("%") ~= "" and vim.bo.buftype == "" then
            vim.api.nvim_command("silent update")
        end
    end,
})

local highlight_group = augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
    desc = "Highlight yank",
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = "*",
})

autocmd("FocusGained", {
    desc = "Update file when there are changes",
    callback = function()
        vim.cmd("checktime")
    end,
})

autocmd("FileType", { pattern = "yaml", command = "setlocal ts=4 sts=4 sw=4 expandtab" })

autocmd({ "BufRead", "BufNewFile" }, {
    desc = "Enable spell checking in filetypes",
    pattern = { "*.txt", "*.md", "*.tex" },
    command = "setlocal spell",
})

autocmd({ "InsertLeave", "WinEnter" }, {
    desc = "Show cursor line only in active window",
    callback = function()
        local ok, cl = pcall(vim.api.nvim_win_get_var, 0, "auto-cursorline")
        if ok and cl then
            vim.wo.cursorline = true
            vim.api.nvim_win_del_var(0, "auto-cursorline")
        end
    end,
})

autocmd({ "InsertEnter", "WinLeave" }, {
    desc = "Disable cursorline when buffer not focused",
    callback = function()
        local cl = vim.wo.cursorline
        if cl then
            vim.api.nvim_win_set_var(0, "auto-cursorline", cl)
            vim.wo.cursorline = false
        end
    end,
})

autocmd({ "FileType" }, {
    desc = "Fix conceallevel for json and help files",
    pattern = { "json", "jsonc" },
    callback = function()
        vim.wo.spell = false
        vim.wo.conceallevel = 0
    end,
})

autocmd("BufReadPost", {
    desc = "Return to last edit location",
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
local ns = vim.api.nvim_create_namespace("toggle_hlsearch")

local function toggle_hlsearch(char)
    if vim.fn.mode() == "n" then
        local keys = { "<CR>", "n", "N", "*", "#", "?", "/" }
        local new_hlsearch = vim.tbl_contains(keys, vim.fn.keytrans(char))

        if vim.opt.hlsearch:get() ~= new_hlsearch then
            vim.opt.hlsearch = new_hlsearch
        end
    end
end

vim.on_key(toggle_hlsearch, ns)
