return {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 100,
    config = function()
        local ok, gruvbox = pcall(require, "gruvbox")
        if not ok then
            return
        end
        gruvbox.setup({
            overrides = {
                GitSignsCurrentLineBlame = { link = "Comment" },
            },
            transparent_mode = true,
            contrast = "hard",
            -- inverse = false,
        })
        vim.cmd.colorscheme("gruvbox")
    end,
}
