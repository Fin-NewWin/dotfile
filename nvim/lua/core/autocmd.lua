local au = vim.api.nvim_create_autocmd

-- Remove auto comments
au('FileType', { command = 'set formatoptions=' })

-- Remove trailing white space
au('BufWritePre', { command = [[%s/\s\+$//e]] })

-- Reload file when chaned outside of nvim
au({'BufEnter', 'CursorHold'}, { command = 'silent! checktime %'})

-- Show diagnostics on dialog on cursor hover
au('CursorHold', {
    callback = function()
        vim.diagnostic.open_float({ focusable = false })
    end,
})

-- Highlight yanked text
au('TextYankPost', {
    callback = function()
        vim.highlight.on_yank({ igroup="IncSearch", timeout=150, on_visual=true })
    end,
})
