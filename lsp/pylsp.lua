return {
  cmd = { 'pylsp' },
  filetypes = { 'python' },
  root_markers = {
    'pyproject.toml',
    'setup.py',
    'setup.cfg',
    'requirements.txt',
    'Pipfile',
    '.git',
  },

  python = {
    analysis = {
      autoSearchPaths = true,
      useLibraryCodeForTypes = true,
      diagnosticMode = 'workspace',
    },
  },


  on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, "formatexpr", "");
  end,

  capabilities = require('cmp_nvim_lsp').default_capabilities()
}
