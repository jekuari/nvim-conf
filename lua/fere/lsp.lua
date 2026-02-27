vim.diagnostic.config({
  virtual_text = true,  -- show inline messages
  signs = true,         -- show signs in the gutter
  underline = true,     -- underline problematic text
  update_in_insert = false, -- don't update diagnostics while typing
  severity_sort = true,     -- sort diagnostics by severity
})

vim.lsp.enable({"pyrefly", "eslint", "ts_ls", "ruff", "gopls"})


vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, {
      buffer = args.buf,
      desc = "Show hover information",
    })
    vim.keymap.set("n", "<leader>dd", vim.lsp.buf.definition, {
      buffer = args.buf,
      desc = "Go to definition",
    })
    vim.keymap.set("n", "<leader>dD", vim.lsp.buf.declaration, {
      buffer = args.buf,
      desc = "Go to declaration",
    })
    vim.keymap.set("n", "<leader>di", vim.lsp.buf.implementation, {
      buffer = args.buf,
      desc = "Go to implementation",
    })
    vim.keymap.set("n", "<leader>dt", vim.lsp.buf.type_definition, {
      buffer = args.buf,
      desc = "Go to type definition",
    })
    vim.keymap.set("n", "<leader>dR", vim.lsp.buf.references, {
      buffer = args.buf,
      desc = "Show references",
    })
    vim.keymap.set("n", "<leader>ds", vim.lsp.buf.signature_help, {
      buffer = args.buf,
      desc = "Show signature help",
    })
    vim.keymap.set("n", "<leader>dr", vim.lsp.buf.rename, {
      buffer = args.buf,
      desc = "Rename symbol",
    })
    vim.keymap.set("n", "<leader>dc", vim.lsp.buf.code_action, {
      buffer = args.buf,
      desc = "Show code actions",
    })
    vim.keymap.set("n", "<leader>dl", vim.diagnostic.open_float, {
      buffer = args.buf,
      desc = "Show diagnostics",
    })
    vim.keymap.set('i', '<c-q>', function()
      local client = vim.lsp.get_clients({ bufnr = 0, name = 'amazonq-completion' })[1]
      if not client then
        vim.notify('Amazon Q not enabled for this buffer')
        return
      end
      vim.lsp.completion.enable(true, client.id, 0)
      vim.notify('Amazon Q: working...')
      vim.lsp.completion.get()
      -- vim.cmd[[redraw | echo '']]
    end)

    end
})

vim.lsp.config('*', {
    on_attach = function(client, bufnr)
        vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
            vim.lsp.diagnostic.on_publish_diagnostics, {
                signs = true,
                underline = true,
                virtual_text = true
            }
        )

    end
})
