-- Manage all of your plugin installations
-- Checkout the awesome neovim github page for more if you need them
local fn = vim.fn

-- Bootstrap packer if not already installed
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path
  }
  print 'Installing packer... Close and reopen neovim'
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand to reload neovim whenever this file is edited
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost packer.lua source <afile> | PackerSync
  augroup end
]]

local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  vim.notify('unable to load packer')
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require('packer.util').float { border = 'rounded' }
    end,
  },
}

return packer.startup(function(use)
  -- Packer manages itself --
  use 'wbthomason/packer.nvim'

  -- Commonly used by others
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'

  -- Colorschemes
  use 'sainnhe/gruvbox-material'
  use 'EdenEast/nightfox.nvim'
  use 'xiyaowong/nvim-transparent'

  -- Autocompletion
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-nvim-lua'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-nvim-lsp-signature-help'

  -- Snippet engine
  use 'L3MON4D3/LuaSnip'
  use 'rafamadriz/friendly-snippets'

  -- LSP plugins --
  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'

  -- Telescope fuzzy finding --
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-telescope/telescope-media-files.nvim'

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }
  use "p00f/nvim-ts-rainbow"
  use "nvim-treesitter/playground"

  -- Git integrations
  use 'lewis6991/gitsigns.nvim'

  -- QoL
  use 'numToStr/Comment.nvim'
  use 'windwp/nvim-autopairs'
  use 'folke/which-key.nvim'

  -- UI
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
  use {
    "startup-nvim/startup.nvim",
    requires = {"nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim"},
  }
  use {
  "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    }
  }

  -- Boostrap packer
  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
  -- DO NOT PUT ANY MORE PLUGINS HERE
end)
