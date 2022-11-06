local status_ok, notify = pcall(require, "notify")
if not status_ok then
    return
end


notify.setup{
    background_colour = "#000000",
    stages = "fade_in_slide_out",
    on_open = nil,
    on_close = nil,
    render = "default",
    timeout = 175,
    minimum_width = 10,
}

vim.notify = notify

-- All print in cmd would go be piped into nvim-notify instead
local old_print = nil

if not old_print then
    old_print = _G.print
end
vim.notify = function(msg, level, opts)
    old_print(tostring(level) .. ": " .. msg .. " : " .. vim.inspect(opts))
    notify(msg, level, opts)
end

print = function(...)
    local print_safe_args = {}
    local _ = { ... }
    for i = 1, #_ do
        table.insert(print_safe_args, tostring(_[i]))
    end
    vim.notify(table.concat(print_safe_args, ' '), "info")
end
