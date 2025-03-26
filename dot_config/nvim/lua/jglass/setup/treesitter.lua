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
