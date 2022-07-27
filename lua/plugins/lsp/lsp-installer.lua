local status_ok, lsp_installer = pcall(require, 'nvim-lsp-installer')
if not status_ok then
  return
end
handlers = require('plugins.lsp.handlers')
lspconfig = require('lspconfig')

lsp_installer.setup {}
lspconfig.sumneko_lua.setup {on_attach = handlers.on_attach }
lspconfig.elmls.setup {on_attach = handlers.on_attach }
lspconfig.rust_analyzer.setup {on_attach = handlers.on_attach }
