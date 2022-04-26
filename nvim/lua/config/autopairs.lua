local status_ok, autopairs = pcall(require, "nvim-autopairs")
if not status_ok then
    return
end

autopairs.setup({
    disable_filetype = { "TelescopePrompt" , "vim" },
    check_ts = true,
    ts_config = {
        lua = {'string'},
    }
})
