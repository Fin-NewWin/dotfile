for _, source in ipairs({

    -- CORE
    "user.core.disable_builtin",
    "user.core.setting",
    "user.core.globals",
    "user.core.key",
    "user.core.autocmd",

    -- PLUGINS
    "user.core.lazy",


}) do
    local source_status, source_err_msg = pcall(require, source)
    if not source_status then
        local err_msg = "Failed to load " .. source .. "\n\n" .. source_err_msg
        vim.notify(err_msg, "error", { title = "Config Error" })
    end
end
