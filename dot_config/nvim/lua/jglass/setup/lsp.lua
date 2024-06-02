-- [[ Configure LSP ]]
-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local lspconfig = require('lspconfig')

lspconfig.gleam.setup {}
lspconfig.gopls.setup {}
lspconfig.lua_ls.setup {
  settings = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  }
}
lspconfig.clangd.setup{}

require('rust-tools').setup({
  tools = {
    inlay_hints = {
      auto = true,
    },
  },
  server = {
    capabilities = capabilities,
    on_attach = on_attach,
  }
})

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false
    }
)
