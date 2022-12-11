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
        use { "ellisonleao/gruvbox.nvim" }

        -- LSP
        use { "neovim/nvim-lspconfig", }
        use { "SmiteshP/nvim-navic", requires = "neovim/nvim-lspconfig" }
        use { "folke/neodev.nvim" }
        use { "ray-x/lsp_signature.nvim" }

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
        }
        use { "L3MON4D3/LuaSnip", requires = "saadparwaiz1/cmp_luasnip" }
        use { "rafamadriz/friendly-snippets" }

        -- Treesitter/Syntax highlight
        use {
            "nvim-treesitter/nvim-treesitter",
            run = ":TSUpdate",
        }


        -- Fuzzy/Grep
        use {
            "nvim-telescope/telescope.nvim",
            requires = {
                "nvim-lua/plenary.nvim",
                "nvim-telescope/telescope-fzy-native.nvim",
                "kyazdani42/nvim-web-devicons",
            },
        }

        -- git
        use { "lewis6991/gitsigns.nvim" }


        -- Util and QOL
        use { "lukas-reineke/indent-blankline.nvim", after = {"nvim-treesitter"} }
        use { "NvChad/nvim-colorizer.lua" }
        use { "ethanholz/nvim-lastplace" }
        use { "numToStr/Comment.nvim" }
        -- use { "rrethy/vim-illuminate", config = get_config("illuminate") }
        use { "nyngwang/murmur.lua" }

        -- autopair plugins
        use { "windwp/nvim-autopairs" }
        use { "windwp/nvim-ts-autotag", requires = { "nvim-treesitter/nvim-treesitter" } }

        -- UI
        use { "rebelot/heirline.nvim" }
        use { "goolord/alpha-nvim" }
        use { "rcarriga/nvim-notify" }
        use {
            "folke/todo-comments.nvim",
            requires = "nvim-lua/plenary.nvim",
        }

    end,
    config = {
        display = {
            prompt_border = "rounded",
            open_fn = function()
                return require("packer.util").float({ border = "rounded" })
            end,
        }
    },
    compile_on_sync = true,
}




-- Source config files
local path = "user.plugin.config."

for _, source in ipairs({

    "lspconfig",
    "treesitter",
    "telescope",
    "cmp",

    "colorscheme",
    "status",

    "autopairs",
    "murmur",
    "comment",
    "colorizer",

    "gitsigns",
    "indent-blankline",
    "notify",
    "todo",

    "alpha",

    "lastplace",

}) do
	local ok, fault = pcall(require, path .. source)
	if not ok then
		local err = "Failed to load " .. path .. source .. "\n\n" .. fault
        vim.notify(err, "error", {title = "Plugin Config Error"})
	end
end

