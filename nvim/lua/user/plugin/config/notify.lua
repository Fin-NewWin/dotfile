local M = {}

function M.config()
    local status_ok, notify = pcall(require, "notify")
    if not status_ok then
        return
    end


    notify.setup({
        background_colour = "#000000",
        timeout = 3000,
        level = 0,
        fps = 20,
        max_height = function()
            return math.floor(vim.o.lines * 0.75)
        end,
        max_width = function()
            return math.floor(vim.o.columns * 0.75)
      end,
    })

    vim.notify = notify
end

return M
