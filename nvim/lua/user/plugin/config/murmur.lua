local ok, murmur = pcall(require, "murmur")
if not ok then
    return
end

murmur.setup {
    max_len = 80,
    cursor_rgb = '#504945',
    exclude_filetypes = {},
    callbacks = {
        function()
            vim.cmd('doautocmd InsertEnter')
            vim.w.diag_shown = false
        end,
    }
}

vim.api.nvim_create_augroup("Murmur", {clear = true})
vim.api.nvim_create_autocmd('CursorHold', {
    group = "Murmur",
    pattern = '*',
    callback = function()
        if vim.w.diag_shown then return end
        if vim.w.cursor_word ~= '' then
            vim.diagnostic.open_float(nil, {
                focusable = true,
                close_events = { 'InsertEnter' },
                border = 'rounded',
                source = 'always',
                prefix = ' ',
                scope = 'cursor',
            })
            vim.w.diag_shown = true
        end
    end
})
