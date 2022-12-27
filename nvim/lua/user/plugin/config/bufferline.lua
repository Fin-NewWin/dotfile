local M = {}

function M.config()
    local status, bufferline = pcall(require, "bufferline")
    if not status then
        return
    end

    local theme
    local gruvbox_ok, gruvbox_groups = pcall(require, "gruvbox.groups")
    if gruvbox_ok then
        theme = gruvbox_groups.setup()
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
        highlights = {
            fill = {
                bg = "#282828"
            },
            tab ={
                bg = "#ff0000"
            },
            tab_selected ={
                bg = "#ff0000"
            },
            buffer_selected ={
                bg = theme.GruvboxBg1.fg
            },
            close_button_selected = {
                bg = theme.GruvboxBg1.fg
            },
            diagnostic_selected = {
                bg = theme.GruvboxBg1.fg
            },
            separator_selected = {
                bg = theme.GruvboxBg1.fg,
                fg = "#282828"
            },
            separator_visible = {
                fg = "#282828"
            },
            pick_selected = {
                bg = theme.GruvboxBg1.fg,
            },
            separator = {
                fg = "#282828",
                bg = "#282828"
            },
        },
        options = {
            show_close_icon = true,
            separator_style = "slant",
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
