local fn = vim.fn
-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
    print("Installing packer close and reopen Neovim...")
    vim.cmd([[packadd packer.nvim]])
end

-- Function to get config
local function get_config(name)
    return string.format('require("user.plugin.config.%s")', name)
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end


packer.startup{
    function(use)

        -- Packer can manage itself
        use { "wbthomason/packer.nvim" }

        -- Init first
        use "lewis6991/impatient.nvim"
        use "nvim-lua/plenary.nvim"

        -- Colorscheme
        use { "ellisonleao/gruvbox.nvim", config = get_config("colorscheme")}

        -- LSP
        use {
            "neovim/nvim-lspconfig",
            config = get_config("lspconfig"),
        }
        use {
            "SmiteshP/nvim-navic",
            requires = "neovim/nvim-lspconfig"
        }
        use "folke/neodev.nvim"

        -- Autcomplete
        use {
            "hrsh7th/nvim-cmp",
            requires = {
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-nvim-lua",
                "hrsh7th/cmp-path",
                "hrsh7th/cmp-buffer",
                "onsails/lspkind.nvim",
                "lukas-reineke/cmp-under-comparator",
            },
            config = get_config("cmp")
        }
        use { "L3MON4D3/LuaSnip", requires = "saadparwaiz1/cmp_luasnip" }
        use { "rafamadriz/friendly-snippets" }

        -- Treesitter/Syntax highlight
        use {
            "nvim-treesitter/nvim-treesitter",
            run = ":TSUpdate",
            config = get_config("treesitter"),
        }


        -- Fuzzy/Grep
        use {
            "nvim-telescope/telescope.nvim",
            requires = {
                "nvim-lua/plenary.nvim",
                "nvim-telescope/telescope-fzy-native.nvim",
                "kyazdani42/nvim-web-devicons",
            },
            config = get_config("telescope")
        }

        -- git
        use { "lewis6991/gitsigns.nvim", config = get_config("gitsigns")}


        -- Util and QOL
        use { "lukas-reineke/indent-blankline.nvim", config = get_config("indent-blankline"), after = {"nvim-treesitter"} }
        use { "NvChad/nvim-colorizer.lua", config = get_config("colorizer") }
        use { "ethanholz/nvim-lastplace", config = get_config("lastplace") }
        use {
            "numToStr/Comment.nvim",
            config = function()
                require("Comment").setup()
            end
        }
        use { "RRethy/vim-illuminate", config = get_config("illuminate") }

        -- autopair plugins
        use { "windwp/nvim-autopairs", config = get_config("autopairs"), after = {"nvim-treesitter"} }
        use { "windwp/nvim-ts-autotag", requires = { "nvim-treesitter/nvim-treesitter" } }

        -- UI
        use { "rebelot/heirline.nvim", config = get_config("status") }
        use { "goolord/alpha-nvim", config = get_config("alpha") }

    end,
    config = {
        display = {
            prompt_border = "rounded",
            open_fn = function()
                return require("packer.util").float({ border = "rounded" })
            end,
        }
    },
    auto_clean = true,
    compile_on_sync = true,
}
