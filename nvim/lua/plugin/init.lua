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

local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Function to get config
local function get_config(name)
	return string.format('require("plugin/config/%s")', name)
end

packer.startup{
	function(use)

		-- Packer can manage itself
		use 'wbthomason/packer.nvim'

		-- Init first
        use { 'nathom/filetype.nvim' }
		use 'lewis6991/impatient.nvim'
        use 'nvim-lua/plenary.nvim'

        -- Colorscheme
        use { 'ellisonleao/gruvbox.nvim', config = get_config('colorscheme')}

        -- LSP with code completion(cmp)
        use {
            'neovim/nvim-lspconfig',
            config = get_config('lspconfig'),
            requires = {
                'onsails/lspkind.nvim',
                {
                    'hrsh7th/nvim-cmp',
                    requires = {
                        'hrsh7th/cmp-nvim-lsp',
                        'hrsh7th/cmp-nvim-lua',
                        'hrsh7th/cmp-path',
                        { 'L3MON4D3/LuaSnip', requires = 'saadparwaiz1/cmp_luasnip' },
                    }
                },
                'j-hui/fidget.nvim'
            }
        }

        -- Treesitter
        use {
            'nvim-treesitter/nvim-treesitter',
            run = ':TSUpdate',
            requires = 'windwp/nvim-ts-autotag',
            config = get_config('nvim-treesitter'),
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


        -- Util and QOL
        use { 'windwp/nvim-autopairs', config = get_config('autopairs'), after = {'nvim-treesitter'} }
        use { 'lukas-reineke/indent-blankline.nvim', config = get_config('indent-blankline'), after = {'nvim-treesitter'} }
        use { 'Akianonymus/nvim-colorizer.lua' }
        use { 'ethanholz/nvim-lastplace' }
        use { 'lewis6991/gitsigns.nvim'}


        if packer_bootstrap then
            require('packer').sync()
        end
	end,
    config = {
        display = {
            prompt_border = 'single'
        }
    }
}

require('plugin.config.others')
