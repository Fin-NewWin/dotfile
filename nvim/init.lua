for _, source in ipairs({
    -- CORE
    "core.disable_builtin",
    "core.setting",
    "core.key",
    "core.autocmd",

    -- PLUGINS
    "core.lazy",
}) do
    local source_status, source_err_msg = pcall(require, source)
    if not source_status then
        local err_msg = "Failed to load " .. source .. "\n\n" .. source_err_msg
        vim.notify(err_msg, 4, { title = "Config Error" })
    end
end

