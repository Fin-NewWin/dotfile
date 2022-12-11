local ok, _ = pcall(require, "impatient")
if ok then
    require("impatient")
end

-- Source basic files to see if not broken
for _, source in ipairs({
    -- CORE
    "user.core.key",
    "user.core.disable_builtin",
    "user.core.setting",
    "user.core.autocmd",

    -- PLUGINS
    "user.plugin",
}) do
    local source_status, source_err_msg = pcall(require, source)
    if not source_status then
        local err_msg = "Failed to load " .. source .. "\n\n" .. source_err_msg
        vim.notify(err_msg, "error", { title = "Config Error" })
    end
end
