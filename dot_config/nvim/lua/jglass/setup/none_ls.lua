local ok, null_ls = pcall(require, 'null-ls')

if not ok then
  return
end

null_ls.setup {
  sources = {
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.mdformat,

    null_ls.builtins.code_actions.proselint,
    null_ls.builtins.diagnostics.proselint,
    null_ls.builtins.completion.spell,
	null_ls.builtins.formatting.stylua
  },
}
