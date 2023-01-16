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
        vim.notify(source .. " error", "error", { title = "Plugin config error" })
        return
    end
    return plugin
end

require("lazy").setup({

    -- Init first
    { "nvim-lua/plenary.nvim" },

    -- Colorscheme
    {
        "ellisonleao/gruvbox.nvim",
        config = get_config("colorscheme").config,
        lazy = false,
        priority = 100,
    },

    -- Treesitter/Syntax highlight
    {
        "nvim-treesitter/nvim-treesitter",
        config = get_config("treesitter").config,
        event = "BufReadPost",
        build = ":TSUpdate",
    },
    { "JoosepAlviste/nvim-ts-context-commentstring" },

    -- LSP
    { "neovim/nvim-lspconfig", config = get_config("lspconfig").config, event = "BufReadPost" },
    { "SmiteshP/nvim-navic" },
    { "folke/neodev.nvim" },
    { "ray-x/lsp_signature.nvim" },


    -- Autocomplete
    {
        "hrsh7th/nvim-cmp",
        config = get_config("cmp").config,
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-cmdline",
            "onsails/lspkind.nvim",
            "lukas-reineke/cmp-under-comparator",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
        },
    },

    -- Fuzzy/Search
    {
        "nvim-telescope/telescope.nvim",
        config = get_config("telescope").config,
        event = "BufReadPre",
        cmd = { "Telescope" },
        dependencies = {
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
            "kyazdani42/nvim-web-devicons",
        },
    },

    -- GIT
    { "lewis6991/gitsigns.nvim", config = get_config("gitsigns").config, event = "BufReadPre", },

    -- Util and QOL
    { "lukas-reineke/indent-blankline.nvim", config = get_config("indent-blankline").config, event = "BufReadPre" },
    { "NvChad/nvim-colorizer.lua", config = get_config("colorizer").config, event = "BufReadPre", },
    { "numToStr/Comment.nvim", config = get_config("comment").config, event = "BufReadPost" },
    { "rcarriga/nvim-notify", config = get_config("notify").config, lazy = false },
    {
        "ggandor/leap.nvim",
        config = true,
        event = "VeryLazy",
        dependencies = { { "ggandor/flit.nvim", opts = { labeled_modes = "nv" } } },
    },
    {"nyngwang/murmur.lua", config = get_config("murmur").config, event = "BufReadPre"},

    -- Autopair
    { "windwp/nvim-autopairs", config = get_config("autopairs").config, event = "InsertEnter" },
    {
        "windwp/nvim-ts-autotag",
        ft = {
            "html",
            "jsx",
            "javascript",
            "tsx",
            "typescript"
        },
        dependencies = { "nvim-treesitter/nvim-treesitter" },
    },


    -- UI
    { "rebelot/heirline.nvim", config = get_config("status").config, event = "BufEnter" },
    { "goolord/alpha-nvim", config = get_config("alpha").config, event = "VimEnter" },
    {
        "anuvyklack/windows.nvim",
        config = true,
        event = "WinNew",
        dependencies = "anuvyklack/middleclass",
    },

}, {
    defaults = { lazy = true },
    checker = { enabled = false },
    ui = {
        border = "rounded"
    }
})
