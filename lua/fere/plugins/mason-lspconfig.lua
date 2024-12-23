return {
  'williamboman/mason-lspconfig.nvim',
  dependenciej = { 'williamboman/mason.nvim', 'neovim/nvim-lspconfig' },
  config = function()
    local mason_lspconfig = require('mason-lspconfig')
    local lspconfig = require('lspconfig')
    mason_lspconfig.setup({
      ensure_installed = {
        'ts_ls',
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
        'r_language_server'
      },
      handlers = {
        function(server_name)
          lspconfig[server_name].setup({})
        end,

        lua_ls = function()
          lspconfig.lua_ls.setup({
            settings = {
              Lua = {
                diagnostics = {
                  globals = { 'vim' }
                }
              }
            }
          })
        end,

        ts_ls = function()
          lspconfig.ts_ls.setup({
            init_options = {
              plugins = {
                {
                  name = "@vue/typescript-plugin",
                  location = "/Users/fere/.nvm/versions/node/v22.3.0/lib/node_modules/@vue/typescript-plugin",
                  languages = { "javascript", "typescript", "vue" },
                },
              },
            },
            filetypes = {
              "javascript",
              "javascriptreact",
              "javascript.jsx",
              "typescript",
              "typescriptreact",
              "typescript.tsx",
              "vue",
            },
            on_attach = function(client)
              client.server_capabilities.documentFormattingProvider = false
              client.server_capabilities.documentFormattingRangeProvider = false
            end,
          })
        end,

        omnisharp = function()
          lspconfig.omnisharp.setup({
            cmd = { "dotnet", "/Users/fere/language_servers/omnisharp/OmniSharp.dll" },
            enable_editorconfig_support = true,
            enable_ms_build_load_projects_on_demand = false,
            enable_roslyn_analyzers = false,
            organize_imports_on_format = false,
            enable_import_completion = false,
            sdk_include_prereleases = true,
            analyze_open_documents_only = false,
          })
        end,

        volar = function()
          lspconfig.volar.setup({
            filetypes = { 'vue' },
            init_options = {
              vue = {
                hybridMode = true
              },
            }
          })
        end,

        emmet_language_server = function()
          lspconfig.emmet_language_server.setup({
            filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
          })
        end,

        tailwindcss = function()
          lspconfig.tailwindcss.setup({
            filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
            on_attach = function(_, bufnr)
              require("tailwindcss-colors").buf_attach(bufnr)
            end
          })
        end,

      },
    })
  end

}
