-- See `:help vim.keymap.set()`
-- See `:help telescope.builtin`

local M = {}

M.general_mappings = function()
	vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
	vim.keymap.set('t', '<C-e>', '<C-\\><C-n>', { silent = true })

	-- Remap for dealing with word wrap
	vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
	vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

	vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles,
		{ desc = '[?] Find recently opened files' })
	vim.keymap.set('n', '<leader>b', require('telescope.builtin').buffers, { desc = 'Find existing [b]uffers' })
	vim.keymap.set('n', '<leader>/', function()
		-- You can pass additional configuration to telescope to change theme, layout, etc.
		require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
			winblend = 10,
			previewer = false,
		})
	end, { desc = '[/] Fuzzily search in current buffer' })

	vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
	vim.keymap.set('n', '<leader>f', require('telescope.builtin').find_files, { desc = '[F]iles' })

	vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Open floating [d]iagnostic message' })
	vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, { desc = 'Type [D]efinition' })
	vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

	vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
	vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
	vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
	vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
	vim.keymap.set('n', '<leader>ss', require('telescope.builtin').lsp_document_symbols,
		{ desc = '[S]search document [S]ymbols' })

	vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, { desc = '[R]ename' })
	vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, { desc = '[L]sp code [A]ction' })
	vim.keymap.set('n', '<leader>ld', vim.diagnostic.open_float, { desc = '[L]sp show [D]iagnostic' })
	vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format, { desc = '[L]sp [F]ormat' })

	vim.keymap.set('n', '<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols,
		{ desc = '[W]orkspace [S]ymbols' })
	vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, { desc = '[W]orkspace [A]dd Folder' })
	vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, { desc = '[W]orkspace [R]emove Folder' })
	vim.keymap.set('n', '<leader>wl', function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, { desc = '[W]orkspace [L]ist Folders' })

	-- Diagnostic keymaps
	vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
	vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })

	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = '[G]oto [D]efinition' })
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = '[G]oto [D]eclaration' })
	vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, { desc = '[G]oto [R]eferences' })
	vim.keymap.set('n', 'gI', vim.lsp.buf.implementation, { desc = '[G]oto [I]mplementation' })

	-- See `:help K` for why this keymap
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover Documentation' })
	vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { desc = 'Signature Documentation' })

	vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
end


-- See `:help telescope` and `:help telescope.setup()`
M.telescope_mappings = function()
	return {
		i = {
			['<C-j>'] = require('telescope.actions').move_selection_next,
			['<C-k>'] = require('telescope.actions').move_selection_previous,
			['<C-u>'] = false,
			['<C-d>'] = false,
		},
	}
end

M.gitsigns_mappings = function(bufnr)
	vim.keymap.set('n', '[h', require('gitsigns').prev_hunk, { buffer = bufnr, desc = '[G]o to [P]revious Hunk' })
	vim.keymap.set('n', ']h', require('gitsigns').next_hunk, { buffer = bufnr, desc = '[G]o to [N]ext Hunk' })
	vim.keymap.set('n', '<leader>gh', require('gitsigns').preview_hunk,
		{ buffer = bufnr, desc = 'Preview [G]it [H]unk' })
	vim.keymap.set('n', '<leader>gd', require('gitsigns').diffthis, { buffer = bufnr, desc = '[G]it [D]iff this' })
end

return M
