local status_ok, notify = pcall(require, "notify")
if not status_ok then
    return
end


notify.setup{
    background_colour = "#000000",
    views = {
        cmdline_popup = {
            border = {
                style = 'rounded',
                padding = { 0, 1 },
            },
            position = {
                row = 5,
                col = "50%",
            },
            size = {
                width = 120,
                height = "auto",
            },
            -- filter_options = {},
            -- win_options = {
            -- winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
            -- },
        },
        popupmenu = {
            enabled = false
        },
    },
    level = 0,
}

vim.notify = notify


-- Utility functions for LSP
vim.api.nvim_create_autocmd({'UIEnter'}, {
    once = true,
    callback = function()
        local Spinner = require('user.util.spinner')
        local spinners = {}

        local function format_msg(msg, percentage)
            msg = msg or ''
            if not percentage then
                return msg
            end
            return string.format('%2d%%\t%s', percentage, msg)
        end

        vim.api.nvim_create_autocmd({'User'}, {
            pattern = {'LspProgressUpdate'},
            group = vim.api.nvim_create_augroup('LSPNotify', {clear = true}),
            desc = 'LSP progress notifications',
            callback = function()
                for _, c in ipairs(vim.lsp.get_active_clients()) do
                    for token, ctx in pairs(c.messages.progress) do
                        if not spinners[c.id] then
                            spinners[c.id] = {}
                        end
                        local s = spinners[c.id][token]
                        if not ctx.done then
                            if not s then
                                spinners[c.id][token] = Spinner(
                                    format_msg(ctx.message, ctx.percentage), vim.log.levels.INFO, {
                                        title = ctx.title and string.format('%s: %s', c.name, ctx.title) or c.name
                                    })
                            else
                                s:update(format_msg(ctx.message, ctx.percentage))
                            end
                        else
                            c.messages.progress[token] = nil
                            if s then
                                s:done(ctx.message or 'Complete', nil, {
                                    icon = '',
                                })
                                spinners[c.id][token] = nil
                            end
                        end
                    end
                end
            end,
        })
    end,
})


vim.lsp.handlers['window/showMessage'] = function(_, result, ctx)
    local client = vim.lsp.get_client_by_id(ctx.client_id)
    local lvl = ({
        'ERROR',
        'WARN',
        'INFO',
        'DEBUG',
    })[result.type]
    notify({ result.message }, lvl, {
        title = 'LSP | ' .. client.name,
        timeout = 10000,
        keep = function()
            return lvl == 'ERROR' or lvl == 'WARN'
        end,
    })
end
