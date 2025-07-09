return {
	"williamboman/mason-lspconfig.nvim",
	dependenciej = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
	config = function()
		local mason_lspconfig = require("mason-lspconfig")
		local lspconfig = require("lspconfig")

    --[[ local ok, wf = pcall(require, "vim.lsp._watchfiles")
      if ok then
         wf._watchfunc = function()
           return function() end
      end
    end ]]

		mason_lspconfig.setup({
			ensure_installed = {
				"ts_ls",
				"eslint",
				"lua_ls",
				"graphql",
				"bashls",
				"tailwindcss",
				"docker_compose_language_service",
				"dockerls",
				"emmet_language_server",
			},
			handlers = {
				function(server_name)
					lspconfig[server_name].setup({})
				end,

				zls = function()
					lspconfig.zls.setup({
						filetypes = { "zig" },
						on_attach = function(client)
							client.server_capabilities.documentFormattingProvider = false
							client.server_capabilities.documentFormatting = false
							client.server_capabilities.documentRangeFormattingProvider = false
							client.resolved_capabilities.document_formatting = false
							client.server_capabilities.document_formatting = false
						end,
					})
				end,

				lua_ls = function()
					lspconfig.lua_ls.setup({
						settings = {
							Lua = {
								diagnostics = {
									globals = { "vim" },
									workspace = {
										-- Make the server aware of your project and modules
										library = vim.api.nvim_get_runtime_file("", true),
										checkThirdParty = false, -- Optional, avoids unnecessary prompts
									},
								},
							},
						},
					})
				end,

				-- eslint
				eslint = function()
					lspconfig.eslint.setup({
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
							client.resolved_capabilities.document_formatting = false
						end,
					})
				end,

				pylsp = function()
					local function organize_imports()
            vim.cmd("PyrightOrganizeImports")
					end

					lspconfig.pyright.setup({
            root_dir = function()
              return vim.fn.getcwd()
            end,
            flags = {debounce_text_changes = 2000},
            settings = {
              python = {
                analysis = {
                  logLevel= "Error"
                }
              }
            },
            on_attach = function(client)
              client.server_capabilities.documentFormattingProvider = false
              client.server_capabilities.documentFormattingRangeProvider = false
              vim.keymap.set("n", "<leader>do", organize_imports, {
                desc = "Organize Imports",
              })
            end,

          })

        end,

				pyright = function()
					local function organize_imports()
            vim.cmd("PyrightOrganizeImports")
					end

					lspconfig.pyright.setup({
            root_dir = function()
              return vim.fn.getcwd()
            end,
            flags = {debounce_text_changes = 15000},
            settings = {
              python = {
                analysis = {
                  logLevel= "Error"
                }
              }
            },
            on_attach = function(client)
              client.server_capabilities.documentFormattingProvider = false
              client.server_capabilities.documentFormattingRangeProvider = false
              vim.keymap.set("n", "<leader>do", organize_imports, {
                desc = "Organize Imports",
              })
            end,

          })

        end,

				ts_ls = function()
					local function organize_imports()
						local params = {
							command = "_typescript.organizeImports",
							arguments = { vim.api.nvim_buf_get_name(0) },
							title = "",
						}
						vim.lsp.buf.execute_command(params)
					end
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
							vim.keymap.set("n", "<leader>do", organize_imports, {
								desc = "Organize Imports",
							})
						end,
						commands = {
							OrganizeImports = {
								organize_imports,
								description = "Organize Imports",
							},
						},
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
						filetypes = { "vue" },
						init_options = {
							vue = {
								hybridMode = true,
							},
						},
					})
				end,

				emmet_language_server = function()
					lspconfig.emmet_language_server.setup({
						filetypes = {
							"html",
							"css",
							"scss",
							"javascript",
							"javascriptreact",
							"typescript",
							"typescriptreact",
							"vue",
						},
					})
				end,

				tailwindcss = function()
					lspconfig.tailwindcss.setup({
						filetypes = {
							"html",
							"css",
							"scss",
							"javascriptreact",
							"typescriptreact",
							"vue",
						},
						on_attach = function(_, bufnr)
							require("tailwindcss-colors").buf_attach(bufnr)
						end,
					})
				end,
			},
		})
	end,
}
