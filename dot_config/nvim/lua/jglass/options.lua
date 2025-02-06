-- See `:help vim.o`
vim.wo.number = true
vim.wo.signcolumn = 'yes'
vim.opt.cmdheight = 0
vim.opt.hlsearch = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.updatetime = 250
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.timeout = true
vim.opt.timeoutlen = 300
vim.opt.completeopt = 'menuone,noselect'
vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus"
vim.opt.showtabline = 0

vim.g.rustaceanvim = {
  tools = {
    inlay_hints = {
      auto = true,
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

vim.g.have_nerd_font = true

vim.cmd.colorscheme 'rose-pine-main'
