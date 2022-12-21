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
            separator_style = "thick",
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
end

return M
