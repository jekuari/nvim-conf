-- 1. Diagnostics Config (Keep this, it's good)
vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
})

vim.api.nvim_create_autocmd("User", {
	pattern = "LazyDone",
	callback = function()
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		local has_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
		if has_cmp then
			capabilities = cmp_lsp.default_capabilities()
		end

		vim.lsp.config("*", {
			capabilities = capabilities,
		})

		vim.lsp.enable({ "pyrefly", "eslint", "ts_ls", "gopls", "vue_ls", "ty", "lua_ls" })
	end,
})

vim.api.nvim_create_autocmd("LspAttach", {
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
	end,
})

vim.lsp.config("*", {
	on_attach = function(client, bufnr)
		-- overwrites omnifunc/tagfunc set by some Python plugins to the
		-- default values for LSP
		vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", { buf = bufnr })
		vim.api.nvim_set_option_value("tagfunc", "v:lua.vim.lsp.tagfunc", { buf = bufnr })
	end,
})
