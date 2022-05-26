-- Color scheme

local schemes = {
  "nightfox",
  "dayfox",
  "nordfox",
  "terafox",
  "gruvbox-material",
}

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. schemes[math.random(#schemes)])
if not status_ok then
  return
end

