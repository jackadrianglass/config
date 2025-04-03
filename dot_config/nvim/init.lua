
-- Based on Kickstart.nvim
-- See `https://learnxinyminutes.com/docs/lua/`
-- See `:help lua-guide`

-- See `:help mapleader`
-- NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.loader.enable()
require('plugins')
require('options')
require('keymaps').general()
require('autocommands')

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
