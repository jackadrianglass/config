-- Bootstrap packer if not already installed
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = vim.fn.system {
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
  use 'morhetz/gruvbox'
  use 'sainnhe/gruvbox-material'
  use 'EdenEast/nightfox.nvim'

  -- Autocompletion
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-nvim-lua'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-nvim-lsp-signature-help'
  use {
    'hrsh7th/nvim-cmp',
    config = function()
      require('plugins.cmp')
    end
  }

  -- Snippet engine
  use 'L3MON4D3/LuaSnip'

  -- LSP plugins --
  use 'williamboman/mason.nvim'
  use "williamboman/mason-lspconfig.nvim"
  use {
    'neovim/nvim-lspconfig',
    config = function()
      require('plugins.lsp')
    end
  }

  -- Telescope fuzzy finding --
  use {
    'nvim-telescope/telescope.nvim',
    config = function()
      require('plugins.telescope')
    end
  }

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require('plugins.treesitter')
    end
  }
  use "nvim-treesitter/playground"

  -- Git integrations
  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('plugins.gitsigns')
    end
  }

  -- QoL
  use {
    'folke/which-key.nvim',
    config = function()
      require('plugins.which-key')
    end
  }
  use {
    'lewis6991/spellsitter.nvim',
    config = function()
      require('spellsitter').setup()
    end
  }

  -- UI
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons'},
    config = function()
      require('plugins.lualine')
    end
  }
  use {
  "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require('plugins.neo-tree')
    end
  }

  -- Boostrap packer
  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
  -- DO NOT PUT ANY MORE PLUGINS HERE
end)
