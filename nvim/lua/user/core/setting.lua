local options = {
    backup          = false,                                    -- Don't create backup file
    breakindent     = true,                                     -- Wrap lines have same indent
    -- clipboard       = "unnamedplus",                            -- Set nvim to use system clipboard
    colorcolumn     = "120",                                    -- vertical column that suggests column limit
    completeopt     = { "menuone", "noselect", "noinsert" },    -- Menu for completion
    cmdheight       = 0,                                        -- Height when using cmd
    cursorline      = true,                                     -- cursorline that's it
    errorbells      = false,                                    -- no beep
    expandtab       = true,                                     -- tabs to spaces
    ignorecase      = true,                                     -- ignore case when searching
    laststatus      = 3,                                        -- global staths
    mouse           = "a",                                      -- enables mouse
    mousemoveevent  = true,                                     -- mouse location matters
    number          = true,                                     -- number line
    pumheight       = 10,                                       -- pop menu height
    relativenumber  = true,                                     -- number line with relative lines
    scrolloff       = 10,                                       -- number of lines before scrolling
    shiftwidth      = 4,                                        -- tab
    showmode        = false,                                    -- mode bottom left of cmd but I have statusline
    sidescrolloff   = 8,                                        -- similar to scrolloff but horizontal scrolling
    signcolumn      = "yes",                                    -- permanent signcolumn
    smartcase       = true,                                     -- case sensitive when uppercase
    softtabstop     = 4,                                        -- tab
    swapfile        = false,                                    -- disable swap
    syntax          = "OFF",                                    -- Treesistter for suntax
    tabstop         = 4,                                        -- tab
    termguicolors   = true,                                     -- true colors
    undofile        = true,                                     -- undo file
    updatetime      = 1000,                                     -- key press timeout
    wrap            = true,                                     -- enable wrap
    writebackup     = false,                                    -- disable backup
}

vim.opt.shortmess:append "c"

for k, v in pairs(options) do
    vim.opt[k] = v
end
