-- Color scheme

local scheme = "gruvbox-material"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. scheme)
if not status_ok then
  vim.notify("colorscheme " .. scheme .. " not found!")
  return
end
