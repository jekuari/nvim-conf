local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp.default_keymaps({ buffer = bufnr })
end)

lsp.ensure_installed({
  "pylsp",
  'tsserver',
  'gopls',
  'golangci_lint_ls',
  'lua_ls',
  'graphql',
  'rust_analyzer',
  'bashls',
  'tailwindcss',
  'docker_compose_language_service',
  'dockerls',
  'volar',
})

require 'lspconfig'.pylsp.setup {}

require('lspconfig').lua_ls.setup {
  on_init = function(client)
    local path = client.workspace_folders[1].name
    if not vim.loop.fs_stat(path .. '/.luarc.json') and not vim.loop.fs_stat(path .. '/.luarc.jsonc') then
      client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using
            -- (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT'
          },
          -- Make the server aware of Neovim runtime files
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME
              -- "${3rd}/luv/library"
              -- "${3rd}/busted/library",
            }
            -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
            -- library = vim.api.nvim_get_runtime_file("", true)
          }
        }
      })

      client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
    end
    return true
  end
}

require 'lspconfig'.gopls.setup {}
require 'lspconfig'.golangci_lint_ls.setup {}
require 'lspconfig'.graphql.setup {}

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
    async = false,
    timeout_ms = 10000,
  },
  servers = {
    ['null-ls'] = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact",
      "typescript.tsx", "graphql", "sass", "css", "scss", "vue" },
  }
})

lsp.format_on_save({
  format_opts = {
    async = false,
    timeout_ms = 10000,
  },
  servers = {
    ['null-ls'] = { "json", "javascript", "javascriptreact", "typescriptreact", "javascript.jsx", "typescript",
      "typescript", "react",
      "typescript.tsx", "graphql", "sass", "css", "scss", "vue" },
    ['gopls'] = { "go", "gomod", "gowork", "gotmpl" },
    ['lua_ls'] = { "lua" }
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
  }
})

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.prettier,
  }
})
