local M = {}

function M.config()
    require("barbecue").setup({
        attach_navic = false,
    })
end

return M
