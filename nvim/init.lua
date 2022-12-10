local ok, _ = pcall(require, "impatient")
if ok then
    require("impatient")
end

local status_ok, notify = pcall(require, "notify")
if not status_ok then
    return
end

-- Source basic files to see if not broken
for _, source in ipairs({

    -- PLUGINS
    "user.plugin",

    -- CORE
    "user.core.disable_builtin",
    "user.core.setting",
    "user.core.autocmd",
    "user.core.key",

}) do
    local source_status, source_err_msg = pcall(require, source)
    if not source_status then
        local err_msg = "Failed to load " .. source .. "\n\n" .. source_err_msg
        notify(err_msg, "error", { title = "Require Error" })
    end
end
