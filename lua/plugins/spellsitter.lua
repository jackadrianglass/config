-- https://github.com/lewis6991/spellsitter.nvim
local status_ok, spellsitter = pcall(require, "spellsitter")
if not status_ok then
  return
end

spellsitter.setup()
