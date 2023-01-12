local M = {}

function M.config()

    local murmur = require("murmur")
    murmur.setup {
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
                    focusable = false,
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
end

return M
