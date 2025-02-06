-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
local telescope = require('telescope')

telescope.setup {
  defaults = {
    mappings = require("jglass.keymaps").telescope(),
	layout_strategy = "vertical",
	previewer = false,
  },
}

-- Enable telescope fzf native, if installed
pcall(telescope.load_extension, 'fzf')
