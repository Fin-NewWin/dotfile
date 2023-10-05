return {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    config = function()
        local sign_text = "▎"
        require("gitsigns").setup({
            signs = {
                add = {
                    hl = "GitSignsAdd",
                    text = sign_text,
                    numhl = "GitSignsAddNr",
                    linehl = "GitSignsAddLn",
                },
                change = {
                    hl = "GitSignsChange",
                    text = sign_text,
                    numhl = "GitSignsChangeNr",
                    linehl = "GitSignsChangeLn",
                },
                delete = {
                    hl = "GitSignsDelete",
                    text = sign_text,
                    numhl = "GitSignsDeleteNr",
                    linehl = "GitSignsDeleteLn",
                },
                changedelete = {
                    hl = "GitSignsChange",
                    text = sign_text,
                    numhl = "GitSignsChangeNr",
                    linehl = "GitSignsChangeLn",
                },
                untracked = {
                    hl = "GitSignsAdd",
                    text = sign_text,
                    numhl = "GitSignsAddNr",
                    linehl = "GitSignsAddLn",
                },
                topdelete = {
                    hl = "GitSignsDelete",
                    text = "‾",
                    numhl = "GitSignsDeleteNr",
                    linehl = "GitSignsDeleteLn",
                },
            },
            sign_priority = 6,
        })
    end,
}
