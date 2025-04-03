-- [[ Configure LSP ]]
-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
local capabilities = require('blink.cmp').get_lsp_capabilities()

local lspconfig = require 'lspconfig'

lspconfig.gleam.setup { capabilities = capabilities }
lspconfig.gopls.setup { capabilities = capabilities }
lspconfig.lua_ls.setup {
  capabilities = capabilities,
  settings = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}
lspconfig.clangd.setup { capabilities = capabilities }
lspconfig.ts_ls.setup { capabilities = capabilities }
-- rust is setup separately
-- haskell is setup separately

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = false,
})
