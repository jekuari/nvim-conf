return {
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v3.x',
  dependencies = { 'neovim/nvim-lspconfig' },
  config = function()
    local lsp = require('lsp-zero')

    local lspconfig = require('lspconfig')
    lsp.on_attach(function(_, bufnr)
      -- see :help lsp-zero-keybindings
      -- to learn the available actions
      lsp.default_keymaps({ buffer = bufnr })

      lsp.default_keymaps({ buffer = bufnr })
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>di', '<cmd>lua vim.lsp.buf.implementation()<CR>',
        { noremap = true, silent = true })
      -- jump to definition using fd
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>dd', '<cmd>lua vim.lsp.buf.definition()<CR>',
        { noremap = true, silent = true })
      -- go to declaration using fD
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>dD', '<cmd>lua vim.lsp.buf.declaration()<CR>',
        { noremap = true, silent = true })
      -- go to type definition using ft
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>dt', '<cmd>lua vim.lsp.buf.type_definition()<CR>',
        { noremap = true, silent = true })

      -- go to references using fr
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>dr', '<cmd>lua vim.lsp.buf.references()<CR>',
        { noremap = true, silent = true })
      -- rename using fR
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>dR', '<cmd>lua vim.lsp.buf.rename()<CR>',
        { noremap = true, silent = true })
      -- show signature help using fs
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ds', '<cmd>lua vim.lsp.buf.signature_help()<CR>',
        { noremap = true, silent = true })
      -- format using ff
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>df', '<cmd>lua vim.lsp.buf.formatting()<CR>',
        { noremap = true, silent = true })
      -- show code actions using fc
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>dc', '<cmd>lua vim.lsp.buf.code_action()<CR>',
        { noremap = true, silent = true })
      -- show diagnostics using fd
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>dl', '<cmd>lua vim.diagnostic.open_float()<CR>',
        { noremap = true, silent = true })
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


    lspconfig.lua_ls.setup({
      settings = {
        Lua = {
          diagnostics = {
            globals = { 'vim' }
          }
        }
      }
    })
    lspconfig.gopls.setup {}
    lspconfig.graphql.setup {}
    lspconfig.emmet_language_server.setup {
      filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
    }

    lspconfig.rust_analyzer.setup {
      settings = {
        ['rust-analyzer'] = {
          diagnostics = {
            enable = false,
          }
        }
      }
    }

    lspconfig.eslint.setup {}

    lspconfig.tsserver.setup {}

    lspconfig.bashls.setup {}

    lspconfig.tailwindcss.setup {
      filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
      on_attach = function(_, bufnr)
        -- other stuff --
        require("tailwindcss-colors").buf_attach(bufnr)
      end
    }

    lspconfig.docker_compose_language_service.setup {}

    lspconfig.dockerls.setup {}

    lspconfig.omnisharp.setup {
      cmd = { "dotnet", "/Users/fere/language_servers/omnisharp/OmniSharp.dll" },

      -- Enables support for reading code style, naming convention and analyzer
      -- settings from .editorconfig.
      enable_editorconfig_support = true,

      -- If true, MSBuild project system will only load projects for files that
      -- were opened in the editor. This setting is useful for big C# codebases
      -- and allows for faster initialization of code navigation features only
      -- for projects that are relevant to code that is being edited. With this
      -- setting enabled OmniSharp may load fewer projects and may thus display
      -- incomplete reference lists for symbols.
      enable_ms_build_load_projects_on_demand = false,

      -- Enables support for roslyn analyzers, code fixes and rulesets.
      enable_roslyn_analyzers = false,

      -- Specifies whether 'using' directives should be grouped and sorted during
      -- document formatting.
      organize_imports_on_format = false,

      -- Enables support for showing unimported types and unimported extension
      -- methods in completion lists. When committed, the appropriate using
      -- directive will be added at the top of the current file. This option can
      -- have a negative impact on initial completion responsiveness,
      -- particularly for the first few completion sessions after opening a
      -- solution.
      enable_import_completion = false,

      -- Specifies whether to include preview versions of the .NET SDK when
      -- determining which version to use for project loading.
      sdk_include_prereleases = true,

      -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
      -- true
      analyze_open_documents_only = false,
    }

    lspconfig.volar.setup({
      filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' },
      init_options = {
        vue = {
          hybridMode = false
        },
      }
    })

    lsp.format_mapping('gq', {
      format_opts = {
        async = true,
        timeout_ms = 10000,
      },
      servers = {
        ['null-ls'] = { "json", "javascript", "javascriptreact", "typescriptreact", "javascript.jsx", "typescript",
          "typescript", "react",
          "typescript.tsx", "graphql", "sass", "css", "scss", "vue", "html"
        },
        ['lua_ls'] = { "lua" },
        ['gopls'] = { "go" },
        ['rust_analyzer'] = { "rust" },
        ['bashls'] = { "sh" },
        ['tailwindcss'] = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
        ['docker_compose_language_service'] = { "yaml" },
        ['dockerls'] = { "dockerfile" },
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
          "typescript.tsx", "graphql", "sass", "css", "scss", "vue", "html"
        },
        ['lua_ls'] = { "lua" },
        ['gopls'] = { "go" },
        ['rust_analyzer'] = { "rust" },
        ['bashls'] = { "sh" },
        ['tailwindcss'] = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
        ['docker_compose_language_service'] = { "yaml" },
        ['dockerls'] = { "dockerfile" },
        ['emmet_language_server'] = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact" },
      }
    })



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
  end
}
