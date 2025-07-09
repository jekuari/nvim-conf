return {
	"neovim/nvim-lspconfig",
	dependencies = { "hrsh7th/cmp-nvim-lsp" },
	config = function()
		-- vim.opt.signcolumn = 'yes'
		local lspconfig = require("lspconfig")
		local lspconfig_defaults = lspconfig.util.default_config
		lspconfig_defaults.capabilities = vim.tbl_deep_extend(
			"force",
			lspconfig_defaults.capabilities,
			require("cmp_nvim_lsp").default_capabilities()
		)

		vim.api.nvim_create_autocmd("LspAttach", {
			desc = "LSP actions",
			callback = function(event)
				local opts = { buffer = event.buf }

				vim.keymap.set("n", "<leader>K", vim.lsp.buf.hover, {
					buffer = event.buf,
					desc = "Show hover information",
				})
				vim.keymap.set("n", "<leader>dd", vim.lsp.buf.definition, {
					buffer = event.buf,
					desc = "Go to definition",
				})
				vim.keymap.set("n", "<leader>dD", vim.lsp.buf.declaration, {
					buffer = event.buf,
					desc = "Go to declaration",
				})
				vim.keymap.set("n", "<leader>di", vim.lsp.buf.implementation, {
					buffer = event.buf,
					desc = "Go to implementation",
				})
				vim.keymap.set("n", "<leader>dt", vim.lsp.buf.type_definition, {
					buffer = event.buf,
					desc = "Go to type definition",
				})
				vim.keymap.set("n", "<leader>dR", vim.lsp.buf.references, {
					buffer = event.buf,
					desc = "Show references",
				})
				vim.keymap.set("n", "<leader>ds", vim.lsp.buf.signature_help, {
					buffer = event.buf,
					desc = "Show signature help",
				})
				vim.keymap.set("n", "<leader>dr", vim.lsp.buf.rename, {
					buffer = event.buf,
					desc = "Rename symbol",
				})
				vim.keymap.set("n", "<leader>dc", vim.lsp.buf.code_action, {
					buffer = event.buf,
					desc = "Show code actions",
				})

				vim.keymap.set("n", "<leader>dl", vim.diagnostic.open_float, {
					buffer = event.buf,
					desc = "Show diagnostics",
				})
			end,
		})

		vim.diagnostic.config({
			float = {
				border = "rounded",
			},
		})

		---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
		local progress = vim.defaulttable()
		vim.api.nvim_create_autocmd("LspProgress", {
			---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
			callback = function(ev)
				local client = vim.lsp.get_client_by_id(ev.data.client_id)
				local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
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
		})
	end,
}
