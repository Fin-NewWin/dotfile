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
        vim.notify(source .. " error", "error", {title = "Plugin config error"})
        return
	end
    return plugin
end

require("lazy").setup({

        -- Init first
        {"nvim-lua/plenary.nvim"},

        -- Colorscheme
        {
            "ellisonleao/gruvbox.nvim",
            lazy = false,
            -- config = get_config("colorscheme").config
            config = get_config("colorscheme").config
        },

        -- Treesitter/Syntax highlight
        {
            "nvim-treesitter/nvim-treesitter",
            dev = false,
            build = ":TSUpdate",
            event = "BufReadPost",
            config = get_config("treesitter").config,
        },

        -- LSP
        {
            "neovim/nvim-lspconfig",
            event = "BufReadPost",
            config = get_config("lspconfig").config,
        },
        "SmiteshP/nvim-navic",
        "folke/neodev.nvim",
        "ray-x/lsp_signature.nvim",


        -- Autocomplete
        {
            "hrsh7th/nvim-cmp",
            event = "InsertEnter",
            dependencies = {
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-nvim-lua",
                "hrsh7th/cmp-path",
                "hrsh7th/cmp-buffer",
                "onsails/lspkind.nvim",
                "lukas-reineke/cmp-under-comparator",
                "L3MON4D3/LuaSnip",
                "saadparwaiz1/cmp_luasnip",
                "rafamadriz/friendly-snippets",
            },
            config = get_config("cmp").config
        },

        -- Fuzzy/Search
        {
            "nvim-telescope/telescope.nvim",
            event = "BufReadPre",
            cmd = { "Telescope" },
            dependencies = {
                "nvim-lua/plenary.nvim",
                { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
                "kyazdani42/nvim-web-devicons",
            },
            config = get_config("telescope").config
        },

        -- GIT
        {
            "lewis6991/gitsigns.nvim",
            event = "BufReadPre",
            config = get_config("gitsigns").config
        },

        -- Util and QOL
        {
            "lukas-reineke/indent-blankline.nvim",
            event = "BufReadPre",
            config = get_config("indent-blankline").config,
            after = {"nvim-treesitter"}
        },
        {
            "NvChad/nvim-colorizer.lua",
            config = get_config("colorizer").config,
            event = "BufReadPre",
        },
        { "ethanholz/nvim-lastplace", config = get_config("lastplace").config, lazy = false },
        { "numToStr/Comment.nvim", config = get_config("comment").config, event = "BufReadPost"},
        { "nyngwang/murmur.lua", config = get_config("murmur").config, event = "BufReadPost" },

        -- Autopair
        { "windwp/nvim-autopairs", config = get_config("autopairs").config, event = "InsertEnter" },
        {
            "windwp/nvim-ts-autotag",
            dependencies = { "nvim-treesitter/nvim-treesitter" },
            ft = {
                "html",
                "jsx",
                "javascript",
                "tsx",
                "typescript"
            }
        },


        -- Lines
        { "rebelot/heirline.nvim", config = get_config("status").config, lazy = false},
        { "goolord/alpha-nvim", config = get_config("alpha").config, lazy = false},
        { "akinsho/bufferline.nvim", config = get_config("bufferline").config, lazy = false}

}, {
    defaults = { lazy = true },
    checker = { enabled = true },
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip",
                "matchit",
                "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
})
