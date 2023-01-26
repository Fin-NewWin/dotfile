return {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    config = function()
        local ok, gitsigns = pcall(require, "gitsigns")
        if not ok then
            vim.notify("gitsigns not in path", 4, { title = "Plugin Error" })
            return
        end

        local sign_text = "▎"
        gitsigns.setup {
            signs = {
                add          = { hl = "GitSignsAdd",    text = sign_text,   numhl = "GitSignsAddNr",    linehl = "GitSignsAddLn" },
                change       = { hl = "GitSignsChange", text = sign_text,   numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
                delete       = { hl = "GitSignsDelete", text = sign_text,   numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
                changedelete = { hl = "GitSignsChange", text = sign_text,   numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
                untracked    = { hl = "GitSignsAdd",    text = sign_text,   numhl = "GitSignsAddNr",    linehl = "GitSignsAddLn" },
                topdelete    = { hl = "GitSignsDelete", text = "‾",         numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
            },
            watch_gitdir = {
                interval = 1000,
                follow_files = true,
            },
            diff_opts = {
                algorithm = "histogram",
                internal = true,
                indent_heuristic = true,
            },
            sign_priority = 6,
        }
    end
}
