local M = {}

---@return string
function M.git_branch()
    if vim.b.gitsigns_status_dict ~= nil then
        return vim.b.gitsigns_status_dict.head
    end
    return ""
end


return M
