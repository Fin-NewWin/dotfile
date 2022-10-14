local options = {
    -------------------------------
    --          File             --
    -------------------------------
    backup = false,                             -- Don't create backup file
    swapfile = false,
    undofile = true,

    -------------------------------
    --          Search           --
    -------------------------------
    incsearch = true,
    ignorecase = true,                          -- ignore case when searching
    smartcase = true,                           -- case sensitive when uppercase

    -------------------------------
    --          UI               --
    -------------------------------
    cursorline = true,
    conceallevel = 0,
    termguicolors = true,
    pumheight = 10,                             -- pop menu height
    completeopt = { 'menuone', 'noselect' },
    showmode = false,                           -- mode bottom left of cmd but I have statusline
    showtabline = 2,                            -- mode bottom left of cmd but I have statusline
    ruler = true,                               -- Always show tab
    number = true,
    relativenumber = true,
    colorcolumn = '80',
    cmdheight = 1,                              -- Height when using cmd
    laststatus = 2,

    -------------------------------
    --          TABS             --
    -------------------------------
    breakindent = true,
    tabstop = 4,
    softtabstop = 4,
    shiftwidth = 4,
    expandtab = true,

    -------------------------------
    --          WRAP             --
    -------------------------------
    wrap = true,
    wrapscan = true,

    -------------------------------
    --        PERFORMANCE        --
    -------------------------------
    updatetime = 50,

    -------------------------------
    --          OTHER            --
    -------------------------------
    syntax = "OFF",                             -- Treesistter for suntax
    mouse = "",                                 -- Disable mouse
    scrolloff = 10,
    errorbells = false,
    clipboard = 'unnamedplus',                  -- Set nvim to use system clipboard
}

vim.opt.shortmess:append "c"

for k, v in pairs(options) do
    vim.opt[k] = v
end
