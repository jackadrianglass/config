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
  { 'nvim-tree/nvim-web-devicons' },
  { 'rose-pine/nvim' },

  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'j-hui/fidget.nvim', opts = {} },
      { 'folke/neodev.nvim' },
      { 'p00f/clangd_extensions.nvim' },
      { 'mrcjkb/haskell-tools.nvim', version = '^4', lazy = false },
      { 'mrcjkb/rustaceanvim', version = '^5', lazy = false },
      {
        'amrbashir/nvim-docs-view',
        lazy = true,
        cmd = 'DocsViewToggle',
        opts = {
          position = 'right',
          width = 60,
        },
      },
      {
        'rachartier/tiny-code-action.nvim',
        event = 'LspAttach',
        config = function()
          require('tiny-code-action').setup { backend = 'delta' }
        end,
      },
      {
        'nvimtools/none-ls.nvim',
        config = function()
          local null_ls = require 'null-ls'

          require('null-ls').setup {
            sources = {
              null_ls.builtins.formatting.stylua,
              null_ls.builtins.formatting.mdformat,

              null_ls.builtins.code_actions.proselint,
              null_ls.builtins.diagnostics.proselint,
              null_ls.builtins.completion.spell,
              null_ls.builtins.formatting.stylua,
            },
          }
        end,
      },
    },
  },

  -- Debugging
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      { 'igorlfs/nvim-dap-view', opts = {} },
    },
    config = function()
      local dap = require 'dap'
      dap.adapters.lldb = {
        type = 'executable',
        command = '/usr/bin/lldb-dap',
        name = 'lldb',
      }

      dap.configurations.rust = {
        {
          {
            name = 'Launch',
            type = 'lldb',
            request = 'launch',
            program = function()
              return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
            end,
            cwd = '${workspaceFolder}',
            stopOnEntry = false,
          },
          initCommands = function()
            local rustc_sysroot = vim.fn.trim(vim.fn.system 'rustc --print sysroot')
            assert(vim.v.shell_error == 0, 'failed to get rust sysroot using `rustc --print sysroot`: ' .. rustc_sysroot)
            local script_file = rustc_sysroot .. '/lib/rustlib/etc/lldb_lookup.py'
            local commands_file = rustc_sysroot .. '/lib/rustlib/etc/lldb_commands'
            return {
              ([[!command script import '%s']]):format(script_file),
              ([[command source '%s']]):format(commands_file),
            }
          end,
        },
      }
    end,
  },

  {
    'saghen/blink.cmp',
    dependencies = { 'L3MON4D3/LuaSnip' },

    version = '1.*',
    opts = {
      -- See :h blink-cmp-config-keymap for defining your own keymap
      keymap = { preset = 'default' },
      snippets = { preset = 'luasnip' },
      completion = { documentation = { auto_show = true } },
      sources = { default = { 'lsp', 'path', 'snippets', 'buffer' } },
      fuzzy = { implementation = 'prefer_rust_with_warning' },
    },
    opts_extend = { 'sources.default' },
  },
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'nushell/tree-sitter-nu',
    },
    build = ':TSUpdate',
  },
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'blanktiger/telescope-rg.nvim' },
    },
    config = function()
      -- See `:help telescope` and `:help telescope.setup()`
      local telescope = require 'telescope'

      telescope.setup {
        defaults = {
          mappings = require('keymaps').telescope(),
          layout_strategy = 'center',
          previewer = false,
        },
      }

      pcall(telescope.load_extension, 'fzf')
      pcall(telescope.load_extension, 'ripgrep')
    end,
  },

  { 'stevearc/oil.nvim', opts = {} },
  { 'lewis6991/gitsigns.nvim', opts = {} },
  { 'folke/which-key.nvim', opts = {} },
  {
    'rachartier/tiny-inline-diagnostic.nvim',
    event = 'VeryLazy',
    priority = 1000,
    config = function()
      require('tiny-inline-diagnostic').setup()
      vim.diagnostic.config { virtual_text = false }
    end,
  },
  { 'hiphish/rainbow-delimiters.nvim' },

  { 'lukas-reineke/indent-blankline.nvim', main = 'ibl' },
  { 'folke/flash.nvim', keys = require('keymaps').flash(), event = 'VeryLazy', opts = {} },
  { 'kazhala/close-buffers.nvim' },
  {
    'kylechui/nvim-surround',
    version = '*',
    event = 'VeryLazy',
    config = function()
      require('nvim-surround').setup {}
    end,
  },
  { 'ThePrimeagen/harpoon', branch = 'harpoon2' },
  { 'OXY2DEV/helpview.nvim', lazy = false },
}, {})

-- [[ Configure LSP ]]
require('neodev').setup()

local capabilities = require('blink.cmp').get_lsp_capabilities()
local lspconfig = require 'lspconfig'

lspconfig.gleam.setup { capabilities = capabilities }
lspconfig.gopls.setup { capabilities = capabilities }
lspconfig.lua_ls.setup { capabilities = capabilities }
lspconfig.clangd.setup { capabilities = capabilities }
lspconfig.ts_ls.setup { capabilities = capabilities }
-- rustaceanvim does the setup
vim.g.rustaceanvim = {
	tools = {
		inlay_hints = {
			auto = true,
		},
		diagnostic = {
			refreshSupport = false,
		},
	},
	server = {
		default_settings = {
			['rust-analyzer'] = {
				checkOnSave = { command = "clippy" },
			}
		},
	},
}

-- haskell is setup separately

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = false,
})

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'vimdoc', 'vim', 'wgsl', 'gleam' },
  auto_install = true,

  highlight = { enable = true },
  indent = { enable = true },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer', -- around argument
        ['ia'] = '@parameter.inner', -- inner argument
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      -- TODO experiment with text object jumps here
      goto_next_start = {
        [']a'] = '@parameter.inner',
        [']f'] = '@function.outer',
        [']c'] = '@class.outer',
      },
      goto_next_end = {
        [']A'] = '@parameter.inner',
        [']F'] = '@function.outer',
        [']C'] = '@class.outer',
      },
      goto_previous_start = {
        ['[a'] = '@parameter.inner',
        ['[f'] = '@function.outer',
        ['[c'] = '@class.outer',
      },
      goto_previous_end = {
        ['[A'] = '@parameter.inner',
        ['[F'] = '@function.outer',
        ['[C'] = '@class.outer',
      },
    },
    -- swap = {
    --   enable = true,
    --   swap_next = {
    --     ['<leader>a'] = '@parameter.inner',
    --   },
    --   swap_previous = {
    --     ['<leader>A'] = '@parameter.inner',
    --   },
    -- },
  },
}
