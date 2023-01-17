-- Bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--single-branch",
        "git@github.com:folke/lazy.nvim.git",
        lazypath,
    })
end
vim.opt.runtimepath:prepend(lazypath)

-- Function to get config
local function get_config(name)
    local source = "user.plugin.config." .. name
    local ok, plugin = pcall(require, source)
    if not ok then
        vim.notify(source .. " error", 4, { title = "Plugin config error" })
        return
    end
    return plugin
end

require("lazy").setup({
    spec = {
        import = "plugins"
    },
    defaults = { lazy = true },
    checker = { enabled = false },
    ui = {
        border = "rounded"
    },
    debug = false
})
