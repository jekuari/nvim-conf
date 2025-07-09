return {
	"stevearc/conform.nvim",
	opts = {},
	config = function()
		local conform = require("conform")
		conform.setup({
			formatters_by_ft = {
				javascript = { "prettierd", "prettier", stop_after_first = true },
				typescript = { "prettierd", "prettier", stop_after_first = true },
				typescriptreact = { "prettierd", "prettier", stop_after_first = true },
				javascriptreact = { "prettierd", "prettier", stop_after_first = true },
				vue = { "prettierd", "prettier", stop_after_first = true },
				html = { "prettierd", "prettier", stop_after_first = true },
				css = { "prettierd", "prettier", stop_after_first = true },
				scss = { "prettierd", "prettier", stop_after_first = true },
				json = { "prettierd", "prettier", stop_after_first = true },
				yaml = { "prettierd", "prettier", stop_after_first = true },
				markdown = { "prettierd", "prettier", stop_after_first = true },
				go = { "gofumpt", "gofmt", "goimports", stop_after_first = true },
				rust = { "rustfmt", stop_after_first = true },
				python = { "ruff_format", "ruff_fix", "ruff_organize_imports" },
				lua = { "stylua", "lua-format", stop_after_first = true },
				sh = { "shfmt", stop_after_first = true },
				dockerfile = { "dockerfilelint", stop_after_first = true },
				zig = { "zig fmt", stop_after_first = true },
			},
		})

		-- autoformat
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*",
			callback = function(args)
				conform.format({ bufnr = args.buf })
			end,
		})

		-- format on gq
		vim.keymap.set({ "n", "x" }, "gq", function()
			conform.format({ bufnr = vim.api.nvim_get_current_buf() })
		end, { desc = "Format file" })

		-- format on <leader>df
		vim.keymap.set("n", "<leader>df", function()
			conform.format({ bufnr = vim.api.nvim_get_current_buf() })
		end, { desc = "Format file" })
	end,
}
