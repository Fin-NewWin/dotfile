local ok, _ = pcall(require, "impatient")
if ok then
    require("impatient")
end

-- Basic setting set early
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.opt.termguicolors = true

local status_ok, notify = pcall(require, "notify")
if status_ok then
    notify.setup({
        background_colour = "#000000",
        level = 0,
    })

    vim.notify = notify
end

-- Source basic files to see if not broken
for _, source in ipairs({

    -- PLUGINS
    "user.plugin",

    -- CORE
    "user.core.setting",
    "user.core.key",
    "user.core.disable_builtin",
    "user.core.autocmd",

}) do
    local source_status, source_err_msg = pcall(require, source)
    if not source_status then
        local err_msg = "Failed to load " .. source .. "\n\n" .. source_err_msg
        vim.notify(err_msg, "error", { title = "Config Error" })
    end
end
