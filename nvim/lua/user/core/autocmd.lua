local au = vim.api.nvim_create_autocmd

-- Remove auto comments
au("FileType", { command = "set formatoptions-=cro" })

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

