-- https://github.com/folke/lazy.nvim
-- `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system {
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable', -- latest stable release
		lazypath,
	}
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
	-- Common
	'nvim-lua/plenary.nvim',
	"nvim-tree/nvim-web-devicons",

	{ -- LSP Configuration & Plugins
		'neovim/nvim-lspconfig',
		dependencies = {
			{ 'williamboman/mason.nvim',          config = true },
			{ 'williamboman/mason-lspconfig.nvim' },
			{ 'j-hui/fidget.nvim',                tag = 'legacy' },
			{ 'folke/neodev.nvim' },
			{ "simrat39/rust-tools.nvim" },
			-- { "epwalsh/obsidian.nvim", }
		},
	},

	-- Debugging
	-- TODO
	-- https://github.com/mfussenegger/nvim-dap
	-- https://github.com/rcarriga/nvim-dap-ui
	--

	{ -- Autocompletion
		'hrsh7th/nvim-cmp',
		dependencies = {
			-- Snippet Engine & its associated nvim-cmp source
			'L3MON4D3/LuaSnip',
			'saadparwaiz1/cmp_luasnip',

			-- Adds LSP completion capabilities
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-path',
			'f3fora/cmp-spell',
			'tzachar/fuzzy.nvim',
			'tzachar/cmp-fuzzy-buffer',
		},
	},

	{ -- Treesitter
		'nvim-treesitter/nvim-treesitter',
		dependencies = {
			'nvim-treesitter/nvim-treesitter-textobjects',
		},
		build = ':TSUpdate',
	},

	{ -- Telescope
		'nvim-telescope/telescope.nvim',
		branch = '0.1.x',
		dependencies = {
			{
				'nvim-telescope/telescope-fzf-native.nvim',
				build = 'make',
				cond = function() return vim.fn.executable 'make' == 1 end,
			},
		},
	},

	-- File system
	{ 'stevearc/oil.nvim',     opts = {} },

	-- Terminal TODO add these plugins and tinker
	{ "willothy/flatten.nvim", opts = {}, lazy = false, priority = 1001 },
	{ "chomosuke/term-edit.nvim", lazy = false },

	-- VCS
	'tpope/vim-fugitive',
	{ 'lewis6991/gitsigns.nvim',             opts = { on_attach = require('jglass.keymaps').gitsigns_mappings, }, },

	-- UI
	{ "catppuccin/nvim",                     name = "catppuccin", },
	{ "rose-pine/nvim",                      name = "rose-pine" },
	{ 'folke/which-key.nvim',                opts = {} },
	{ 'nvim-lualine/lualine.nvim',           opts = require("jglass.config.lualine") },
	-- TODO
	-- https://github.com/ellisonleao/glow.nvim
	-- https://github.com/iamcco/markdown-preview.nvim
	-- https://github.com/davidgranstrom/nvim-markdown-preview
	-- https://github.com/richardbizik/nvim-toc
	-- https://github.com/sunjon/Shade.nvim

	-- QoL
	{ 'lukas-reineke/indent-blankline.nvim', main = "ibl" },
	'tpope/vim-sleuth',
}, {})
