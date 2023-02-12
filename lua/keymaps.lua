local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-e>", "<C-\\><C-N>", term_opts)

local wk = require("which-key")

wk.register({
  ["<leader>"] = {
    b = { "<cmd>lua require('telescope.builtin').buffers({ignore_current_buffer = true, sort_lastused = true})<CR>",
      "Current open buffers" },
    d = { "<cmd>lua require('telescope.builtin').diagnostics()<CR>", "Line Diagnostics" },
    f = { "<cmd>lua require'telescope.builtin'.fd(require('telescope.themes').get_dropdown({ previewer = false }))<cr>",
      "Find Files" },
    g = { "<cmd>lua require('telescope.builtin').live_grep()<CR>", "Live Grep" },
    G = { "<cmd>lua require('telescope.builtin').live_grep({grep_open_files = true})<CR>", "Live Grep Open" },
    r = { "<cmd>lua require('telescope.builtin').lsp_references()<CR>", "LSP references" },
    R = { "<cmd>lua require('telescope.builtin').registers()<CR>", "Vim Registers" },
    t = { "<cmd>Neotree toggle filesystem float reveal<CR>", "Show the filesystem" },
  }
})
