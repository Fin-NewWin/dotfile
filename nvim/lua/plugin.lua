-- Install packer if not already
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', { command = 'source <afile> | PackerCompile', group = packer_group, pattern = 'init.lua' })

local packer = require('packer')

-- Function to get config
local function get_config(name)
	return string.format('require("config/%s")', name)
end

packer.startup{
	function(use)

		-- Packer can manage itself
		use 'wbthomason/packer.nvim'

		-- Init first
        use { 'nathom/filetype.nvim', config = get_config('filetype') }
		use 'lewis6991/impatient.nvim'
        use 'nvim-lua/plenary.nvim'

        -- Colorscheme
        use { 'ellisonleao/gruvbox.nvim', config = get_config('gruvbox') }

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
                        'hrsh7th/cmp-path',
                        { 'L3MON4D3/LuaSnip', requires = 'saadparwaiz1/cmp_luasnip' },
                    }
                }
            }
        }

        -- Status line
        use {
            'feline-nvim/feline.nvim',
            config = get_config('feline'),
            requires = {
                { 'lewis6991/gitsigns.nvim', config = get_config('gitsigns')},
            },
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
        use { 'norcalli/nvim-colorizer.lua', config = get_config('nvim-colorizer') }
        use { 'ethanholz/nvim-lastplace', config = get_config('nvim-lastplace') }

	end,
    config = {
        display = {
            prompt_border = 'single'
        }
    }
}
