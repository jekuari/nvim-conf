return {
  "neovim/nvim-lspconfig",
  dependencies = { "hrsh7th/cmp-nvim-lsp" },
  config = function()
    -- vim.opt.signcolumn = 'yes'
    local lspconfig = require('lspconfig')
    local lspconfig_defaults = lspconfig.util.default_config
    lspconfig_defaults.capabilities = vim.tbl_deep_extend(
      'force',
      lspconfig_defaults.capabilities,
      require('cmp_nvim_lsp').default_capabilities()
    )

    vim.api.nvim_create_autocmd('LspAttach', {
      desc = 'LSP actions',
      callback = function(event)
        local opts = { buffer = event.buf }

        vim.keymap.set('n', '<leader>K', '<cmd>lua vim.lsp.buf.hover()<cr>', {
          buffer = event.buf,
          desc = 'Show hover information'
        })
        vim.keymap.set('n', '<leader>dd', '<cmd>lua vim.lsp.buf.definition()<cr>', {
          buffer = event.buf,
          desc = 'Go to definition'
        })
        vim.keymap.set('n', '<leader>dD', '<cmd>lua vim.lsp.buf.declaration()<cr>', {
          buffer = event.buf,
          desc = 'Go to declaration'
        })
        vim.keymap.set('n', '<leader>di', '<cmd>lua vim.lsp.buf.implementation()<cr>', {
          buffer = event.buf,
          desc = 'Go to implementation'
        })
        vim.keymap.set('n', '<leader>dt', '<cmd>lua vim.lsp.buf.type_definition()<cr>', {
          buffer = event.buf,
          desc = 'Go to type definition'
        })
        vim.keymap.set('n', '<leader>dR', '<cmd>lua vim.lsp.buf.references()<cr>', {
          buffer = event.buf,
          desc = 'Show references'
        })
        vim.keymap.set('n', '<leader>ds', '<cmd>lua vim.lsp.buf.signature_help()<cr>', {
          buffer = event.buf,
          desc = 'Show signature help'
        })
        vim.keymap.set('n', '<leader>dr', '<cmd>lua vim.lsp.buf.rename()<cr>', {
          buffer = event.buf,
          desc = 'Rename symbol'
        })
        vim.keymap.set('n', '<leader>dc', '<cmd>lua vim.lsp.buf.code_action()<cr>', {
          buffer = event.buf,
          desc = 'Show code actions'
        })

        vim.keymap.set('n', '<leader>dl', '<cmd>lua vim.diagnostic.open_float()<cr>', {
          buffer = event.buf,
          desc = 'Show diagnostics'
        })
      end,
    })
  end
}
