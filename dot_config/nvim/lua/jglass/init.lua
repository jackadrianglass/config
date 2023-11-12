-- Based on Kickstart.nvim
-- See `https://learnxinyminutes.com/docs/lua/`
-- See `:help lua-guide`

-- See `:help mapleader`
-- NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require('jglass.plugins')
require('jglass.options')
require('jglass.keymaps').general_mappings()
require('jglass.autocommands')
require('jglass.setup')

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
