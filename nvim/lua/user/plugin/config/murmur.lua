local M = {}

function M.config()

    local murmur = require("murmur")
    murmur.setup {
        cursor_rgb = {
            guibg = '#565656',
        },
        min_len = 2,
    }


    local group = "Murmur"
    vim.api.nvim_create_augroup(group, { clear = true })
    vim.api.nvim_create_autocmd("CursorHold", {
        group = group,
        pattern = '*',
        callback = function()

            -- if vim.w.diag_shown then return end

            if vim.w.cursor_word ~= '' then
                vim.diagnostic.open_float(nil, {
                    focusable = false,
                    close_events = { "CursorMoved", "InsertEnter"},
                    border = "rounded",
                    source = "always",
                    scope = "cursor",
                })
                vim.w.diag_shown = true
            end
        end
    })
end

return M
