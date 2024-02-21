local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp.default_keymaps({ buffer = bufnr })
end)

require('mason').setup({})
require('mason-lspconfig').setup({
  -- Replace the language servers listed here
  -- with the ones you want to install
  ensure_installed = {
    'tsserver',
    'gopls',
    'lua_ls',
    'graphql',
    'rust_analyzer',
    'bashls',
    'tailwindcss',
    'docker_compose_language_service',
    'dockerls',
    'volar',
    'emmet_language_server',
  },
  handlers = {
    lsp.default_setup,
  },
})

require('lspconfig').lua_ls.setup({
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      }
    }
  }
})
require 'lspconfig'.gopls.setup {}
require 'lspconfig'.graphql.setup {}
require 'lspconfig'.emmet_language_server.setup {
  filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
}

require 'lspconfig'.rust_analyzer.setup {
  settings = {
    ['rust-analyzer'] = {
      diagnostics = {
        enable = false,
      }
    }
  }
}

require 'lspconfig'.eslint.setup {}

require 'lspconfig'.tsserver.setup {}

require 'lspconfig'.bashls.setup {}

require 'lspconfig'.tailwindcss.setup {
  filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
  on_attach = function(_, bufnr)
    -- other stuff --
    require("tailwindcss-colors").buf_attach(bufnr)
  end
}

require 'lspconfig'.docker_compose_language_service.setup {}

require 'lspconfig'.dockerls.setup {}

lsp.format_mapping('gq', {
  format_opts = {
    async = true,
    timeout_ms = 10000,
  },
  servers = {
    ['null-ls'] = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact",
      "typescript.tsx", "graphql", "sass", "css", "scss", "vue" },
  }
})

lsp.format_on_save({
  format_opts = {
    async = true,
    timeout_ms = 10000,
  },
  servers = {
    ['null-ls'] = { "json", "javascript", "javascriptreact", "typescriptreact", "javascript.jsx", "typescript",
      "typescript", "react",
      "typescript.tsx", "graphql", "sass", "css", "scss", "vue",
    },
    ['lua_ls'] = { "lua" },
    ['gopls'] = { "go" },
    ['rust_analyzer'] = { "rust" },
    ['bashls'] = { "sh" },
    ['tailwindcss'] = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
    ['docker_compose_language_service'] = { "yaml" },
    ['dockerls'] = { "dockerfile" },
    ['volar'] = { "vue" },
    ['emmet_language_server'] = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
  }
})


require 'lspconfig'.volar.setup {
  filetypes = { 'vue' }
}

lsp.setup()

local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.formatting.gofmt,
    null_ls.builtins.formatting.goimports,
    null_ls.builtins.formatting.goimports_reviser
  }
})

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.formatting.gofmt,
    null_ls.builtins.formatting.goimports,
    null_ls.builtins.formatting.goimports_reviser
  }
})
