local signs = {
  { name = "DiagnosticSignError", text = "" },
  { name = "DiagnosticSignWarn", text = "" },
  { name = "DiagnosticSignHint", text = "" },
  { name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

local config = {
  virtual_text = true,
  -- show signs
  signs = {
    active = signs,
  },
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
}

vim.diagnostic.config(config)

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "rounded",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = "rounded",
})

local function lsp_highlight_document(client)
  -- Set autocommands conditional on server_capabilities
  if client.server_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]] ,
      false
    )
  end
end

local function lsp_keymaps(bufnr)
  local wk = require "which-key"
  wk.register({
    ["K"] = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover" },
    ["<A-K>"] = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature Help" },
    ["<leader>l"] = {
      name = "LSP",
      d = { "<cmd>lua vim.diagnostic.open_float()<CR>", "Diagnostic Float" },
      l = { "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({ border = 'rounded' })<CR>", "Show Line Diagnostics" },
      r = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename Symbol" },
      a = { "<cmd>lua vim.lsp.buf.code_action({ border = 'rounded' })<CR>", "Show Available Code Actions" },
      f = { "<cmd>lua vim.lsp.buf.format { async = true }<CR>", "Format the current buffer" }
    },
    g = {
      l = { "<cmd>lua vim.diagnostic.goto_next()<CR>", "Next diagnostic" },
      h = { "<cmd>lua vim.diagnostic.goto_prev()<CR>", "Previous diagnostic" },
      D = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Go to declaration" },
      d = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Go to definition" },
      i = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Go to implementation" },
      r = { "<cmd>lua vim.lsp.buf.references()<CR>" }
    }
  })
end

local function on_attach(client, bufnr)
  lsp_keymaps(bufnr)
  lsp_highlight_document(client)
end

local client_capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_nvim_lsp = require("cmp_nvim_lsp")
local _ = cmp_nvim_lsp.default_capabilities(client_capabilities)

local lspconfig = require('lspconfig')

require("mason").setup()
require("mason-lspconfig").setup()

lspconfig.sumneko_lua.setup {
  on_attach = on_attach,
  config = {
    settings = {
      lua = {
        diagnostics = {
          globals = { 'vim' },
        },
        workspace = {
          library = {
            [vim.fn.expand('$VIMRUNTIME/lua')] = true,
            [vim.fn.stdpath('config') .. '/lua'] = true,
          },
        },
      },
    },
  }
}
lspconfig.elmls.setup { on_attach = on_attach }
lspconfig.rust_analyzer.setup { on_attach = on_attach }
