return {
  cmd = { 'ty', 'server' },
  filetypes = { 'python' },
  root_markers = { 'ty.toml', 'pyproject.toml', '.git' },
  capabilities = require('cmp_nvim_lsp').default_capabilities()
}
