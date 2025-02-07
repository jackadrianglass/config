-- https://github.com/folke/lazy.nvim
-- `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system {
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable',
		lazypath,
	}
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
	{ 'nvim-lua/plenary.nvim' },
	{ "nvim-tree/nvim-web-devicons" },
	{ "rose-pine/nvim" },

	{ -- LSP Configuration & Plugins
		'neovim/nvim-lspconfig',
		dependencies = {
			{ 'j-hui/fidget.nvim' },
			{ 'folke/neodev.nvim' },
			{ "p00f/clangd_extensions.nvim" },
			{
				'mrcjkb/rustaceanvim',
				version = '^5',
				lazy = false,
			},
			{
				"amrbashir/nvim-docs-view",
				lazy = true,
				cmd = "DocsViewToggle",
				opts = {
					position = "right",
					width = 60
				}
			},
			{
				"rachartier/tiny-code-action.nvim",
				event = "LspAttach",
				config = function()
					require('tiny-code-action').setup({ backend = "delta" })
				end
			}
		},
	},

	-- Debugging
	-- TODO
	-- https://github.com/mfussenegger/nvim-dap
	-- https://github.com/rcarriga/nvim-dap-ui
	--

	{
		'hrsh7th/nvim-cmp',
		dependencies = {
			'L3MON4D3/LuaSnip',
			'saadparwaiz1/cmp_luasnip',
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-path',
		},
	},

	{
		'nvim-treesitter/nvim-treesitter',
		dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
		build = ':TSUpdate',
	},
	{
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
	{ 'stevearc/oil.nvim',                   opts = {} },

	-- VCS
	{ "NeogitOrg/neogit",                    dependencies = { "sindrets/diffview.nvim", }, config = true },

	-- UI
	{ 'folke/which-key.nvim',                opts = {} },

	-- QoL
	{ 'lukas-reineke/indent-blankline.nvim', main = "ibl" },
	{ "folke/flash.nvim",                    keys = require('jglass.keymaps').flash(),     event = "VeryLazy", opts = {} },
	{ "kazhala/close-buffers.nvim" },

}, {})
