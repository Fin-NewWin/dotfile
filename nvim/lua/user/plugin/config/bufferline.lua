local M = {}

function M.config()
    local status, bufferline = pcall(require, "bufferline")
    if not status then
        return
    end

    local signs = {
        error   = " ",
        warning = " ",
        hint    = " ",
        info    = " ",
    }

    local severities = {
        "error",
        "warning",
        -- "hint",
        -- "info",
    }

    bufferline.setup({
        options = {
            show_close_icon = true,
            diagnostics = "nvim_lsp",
            -- separator_style = "thick",
            diagnostics_indicator = function(_, _, diag)
                local s = {}
                for _, severity in ipairs(severities) do
                    if diag[severity] then
                        table.insert(s, signs[severity] .. diag[severity])
                    end
                end
                return table.concat(s, " ")
            end,
        },
    })
    vim.api.nvim_create_autocmd("User", {
        pattern = "AlphaReady",
        desc = "disable tabline for alpha",
        callback = function()
            vim.opt.showtabline = 0
        end,
    })
    vim.api.nvim_create_autocmd("BufUnload", {
        buffer = 0,
        desc = "enable tabline after alpha",
        callback = function()
            vim.opt.showtabline = 2
        end,
    })
end
return M
