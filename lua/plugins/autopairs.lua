local status_ok, npairs = pcall(require, "nvim-autopairs")
if not status_ok then
  return
end

-- These are default values that you can override if you'd like
npairs.setup({
  disable_filetype = { "TelescopePrompt" , "vim" },
  disable_in_macro = false,
  disable_in_visualblock = false,
  ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]],"%s+", ""),
  enable_moveright = true,
  enable_afterquote = true,
  enable_check_bracket_line = true,
  enable_bracket_in_quote = true,
  check_ts = false,
  map_cr = true,
  map_bs = true,
  map_c_h = false,
  map_c_w = false,
})
