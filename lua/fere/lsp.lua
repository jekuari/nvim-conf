vim.diagnostic.config({
	virtual_text = true, -- show inline messages
	signs = true, -- show signs in the gutter
	underline = true, -- underline problematic text
	update_in_insert = false, -- don't update diagnostics while typing
	severity_sort = true, -- sort diagnostics by severity
})

vim.lsp.enable({ "pyrefly", "eslint", "ts_ls" })

--[[ local progress = vim.defaulttable()
vim.api.nvim_create_autocmd("LspProgress", {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local value = ev.data.params.value
    if not client or type(value) ~= "table" then
      return
    end
    local p = progress[client.id]

    for i = 1, #p + 1 do
      if i == #p + 1 or p[i].token == ev.data.params.token then
        p[i] = {
          token = ev.data.params.token,
          msg = ("[%3d%%] %s%s"):format(
            value.kind == "end" and 100 or value.percentage or 100,
            value.title or "",
            value.message and (" **%s**"):format(value.message) or ""
          ),
          done = value.kind == "end",
        }
        break
      end
    end

    local msg = {} ---@type string[]
    progress[client.id] = vim.tbl_filter(function(v)
      return table.insert(msg, v.msg) or not v.done
    end, p)

    local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
    vim.notify(table.concat(msg, "\n"), "info", {
      id = "lsp_progress",
      title = client.name,
      opts = function(notif)
        notif.icon = #progress[client.id] == 0 and " "
          or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
      end,
    })
  end,
}) ]]

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

		vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
			signs = true,
			underline = true,
			virtual_text = true,
		})
	end,
})
