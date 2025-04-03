-- See `:help vim.keymap.set()`
-- See `:help telescope.builtin`

local M = {}

M.general = function()
  vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
  vim.keymap.set('t', '<C-e>', '<C-\\><C-n>', { silent = true })

  -- Remap for dealing with word wrap
  vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
  vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

  vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
  vim.keymap.set('n', '<leader>b', require('telescope.builtin').buffers, { desc = 'Find existing [b]uffers' })
  vim.keymap.set('n', '<leader>f', require('telescope.builtin').find_files, { desc = '[F]iles' })

  vim.keymap.set('n', '<leader>sc', require('telescope.builtin').commands, { desc = '[S]earch [C]ommands' })
  vim.keymap.set('n', '<leader>sb', require('telescope.builtin').current_buffer_fuzzy_find, { desc = '[S]earch [B]uffer' })
  vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
  vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
  vim.keymap.set('n', '<leader>ss', require('telescope.builtin').lsp_document_symbols, { desc = '[S]search document [S]ymbols' })
  vim.keymap.set('n', '<leader>sw', require('telescope.builtin').lsp_workspace_symbols, { desc = '[S]search document [W]orkspace symbols' })
  vim.keymap.set('n', '<leader>sz', require('telescope.builtin').git_status, { desc = '[S]search document [Z]e git status' })
  vim.keymap.set('n', '<leader>sa', require('telescope.builtin').resume, { desc = '[S]search [A]gain' })
  vim.keymap.set('n', '<leader>sg', function()
    require('telescope').extensions.ripgrep.ripgrep_files {}
  end, {})
  vim.keymap.set('n', '<leader>st', function()
    require('telescope').extensions.ripgrep.ripgrep_text {}
  end, {})
  vim.keymap.set('n', '<leader>sa', function()
    require('telescope').extensions.ripgrep.ripgrep_text {
      curr_file_dir = true,
    }
  end, {})

  vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, { desc = '[R]ename' })
  vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, { desc = '[L]sp code [A]ction' })
  vim.keymap.set('n', '<leader>c', function()
    require('tiny-code-action').code_action {}
  end, { noremap = true, silent = true })
  vim.keymap.set('n', '<leader>ld', vim.diagnostic.open_float, { desc = '[L]sp show [D]iagnostic' })
  vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format, { desc = '[L]sp [F]ormat' })

  -- Diagnostic keymaps
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })

  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = '[G]oto [D]efinition' })
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = '[G]oto [D]eclaration' })
  vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, { desc = '[G]oto [R]eferences' })
  vim.keymap.set('n', 'gI', require('telescope.builtin').lsp_implementations, { desc = '[G]oto [I]mplementation' })
  vim.keymap.set('n', 'gk', require('telescope.builtin').lsp_type_definitions, { desc = '[G]oto type def ([k]ind)' })

  -- See `:help K` for why this keymap
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover Documentation' })
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { desc = 'Signature Documentation' })

  vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })

  local harpoon = require 'harpoon'
  harpoon:setup {}

  -- basic telescope configuration
  local conf = require('telescope.config').values
  local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
      table.insert(file_paths, item.value)
    end

    require('telescope.pickers')
      .new({}, {
        prompt_title = 'Harpoon',
        finder = require('telescope.finders').new_table {
          results = file_paths,
        },
        previewer = conf.file_previewer {},
        sorter = conf.generic_sorter {},
      })
      :find()
  end

  vim.keymap.set('n', '<leader>h', function()
    toggle_telescope(harpoon:list())
  end, { desc = 'Open harpoon window' })
  vim.keymap.set('n', '<leader>a', function()
    harpoon:list():add()
  end)

  vim.keymap.set('n', '<leader>1', function()
    harpoon:list():select(1)
  end)
  vim.keymap.set('n', '<leader>2', function()
    harpoon:list():select(2)
  end)
  vim.keymap.set('n', '<leader>3', function()
    harpoon:list():select(3)
  end)
  vim.keymap.set('n', '<leader>4', function()
    harpoon:list():select(4)
  end)
  vim.keymap.set('n', '<leader>5', function()
    harpoon:list():select(5)
  end)
  vim.keymap.set('n', '<leader>6', function()
    harpoon:list():select(6)
  end)
  vim.keymap.set('n', '<leader>7', function()
    harpoon:list():select(7)
  end)
  vim.keymap.set('n', '<leader>8', function()
    harpoon:list():select(8)
  end)
  vim.keymap.set('n', '<leader>9', function()
    harpoon:list():select(9)
  end)

  -- Toggle previous & next buffers stored within Harpoon list
  vim.keymap.set('n', '<C-h>', function()
    harpoon:list():prev()
  end)
  vim.keymap.set('n', '<C-l>', function()
    harpoon:list():next()
  end)

  vim.keymap.set('n', '<leader>dc', function()
    require('dap').continue()
  end)
  vim.keymap.set('n', '<leader>db', function()
    require('dap').toggle_breakpoint()
  end)
end

-- See `:help telescope` and `:help telescope.setup()`
M.telescope = function()
  return {
    i = {
      ['<C-j>'] = require('telescope.actions').move_selection_next,
      ['<C-k>'] = require('telescope.actions').move_selection_previous,
      ['<C-u>'] = false,
      ['<C-d>'] = false,
    },
  }
end

M.flash = function()
  return {
    {
      's',
      mode = { 'n', 'x', 'o' },
      function()
        require('flash').jump()
      end,
      desc = 'Flash',
    },
    {
      'S',
      mode = { 'n', 'x', 'o' },
      function()
        require('flash').treesitter()
      end,
      desc = 'Flash Treesitter',
    },
    {
      'r',
      mode = 'o',
      function()
        require('flash').remote()
      end,
      desc = 'Remote Flash',
    },
    {
      'R',
      mode = { 'o', 'x' },
      function()
        require('flash').treesitter_search()
      end,
      desc = 'Treesitter Search',
    },
    {
      '<c-s>',
      mode = { 'c' },
      function()
        require('flash').toggle()
      end,
      desc = 'Toggle Flash Search',
    },
  }
end

return M
