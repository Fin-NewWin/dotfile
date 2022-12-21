local M = {}

function M.config()
    require('Comment').setup({
        ignore = '^$'
    })
end

return M
