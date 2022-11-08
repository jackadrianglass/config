local status_ok, _ = pcall(require, 'lspconfig')
if not status_ok then
  return
end

local handlers = require('plugins.lsp.handlers')
local lspconfig = require('lspconfig')

require("mason").setup()
require("mason-lspconfig").setup()

lspconfig.sumneko_lua.setup {on_attach = handlers.on_attach, config = require("plugins.lsp.settings.sumneko_lua")}
lspconfig.elmls.setup {on_attach = handlers.on_attach }
lspconfig.rust_analyzer.setup {on_attach = handlers.on_attach }
