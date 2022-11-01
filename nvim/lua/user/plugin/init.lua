-- Bootstrap
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

-- Function to get config
local function get_config(name)
    return string.format('require("user.plugin.config.%s")', name)
end

local packer = require('packer')

packer.startup{
    function(use)

        -- Packer can manage itself
        use { 'wbthomason/packer.nvim' }

        -- Init first
        use 'lewis6991/impatient.nvim'
        use 'nvim-lua/plenary.nvim'

        -- Colorscheme
        use { 'ellisonleao/gruvbox.nvim', config = get_config('colorscheme')}

        -- LSP
        use {
            'neovim/nvim-lspconfig',
            config = get_config('lspconfig'),
        }

        -- Autcomplete
        use {
            'hrsh7th/nvim-cmp',
            requires = {
                'hrsh7th/cmp-nvim-lsp',
                'hrsh7th/cmp-nvim-lua',
                'hrsh7th/cmp-path',
                'onsails/lspkind.nvim',
            },
            config = get_config('cmp')
        }
        use { 'L3MON4D3/LuaSnip', requires = 'saadparwaiz1/cmp_luasnip' }
        use { 'rafamadriz/friendly-snippets' }
        use "folke/neodev.nvim"

        -- Treesitter/Syntax highlight
        use {
            'nvim-treesitter/nvim-treesitter',
            run = ':TSUpdate',
            config = get_config('treesitter'),
        }


        -- Telescope
        use {
            'nvim-telescope/telescope.nvim',
            requires = {
                'nvim-lua/plenary.nvim',
                'nvim-telescope/telescope-fzy-native.nvim',
                'kyazdani42/nvim-web-devicons',
            },
            config = get_config('telescope')
        }

        -- git
        use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }
        use { 'lewis6991/gitsigns.nvim', config = get_config('gitsigns')}


        -- Util and QOL
        use { 'windwp/nvim-autopairs', config = get_config('autopairs'), after = {'nvim-treesitter'} }
        use { 'lukas-reineke/indent-blankline.nvim', config = get_config('indent-blankline'), after = {'nvim-treesitter'} }
        use { 'Akianonymus/nvim-colorizer.lua', config = get_config('colorizer') }
        use { 'ethanholz/nvim-lastplace', config = get_config('lastplace') }
        use { 'windwp/nvim-ts-autotag', requires = { 'nvim-treesitter/nvim-treesitter' } }

        -- Status line and bufferline
        use { 'akinsho/bufferline.nvim',
            config = get_config('bufferline'),
            requires = 'kyazdani42/nvim-web-devicons'
        }
        use { 'rebelot/heirline.nvim', config = get_config('status')}


        if packer_bootstrap then
            require('packer').sync()
        end
    end,
    config = {
        display = {
            prompt_border = 'rounded'
        }
    }
}
