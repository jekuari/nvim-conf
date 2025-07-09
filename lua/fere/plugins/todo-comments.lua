return {
	"folke/todo-comments.nvim",
	event = "BufRead",
	config = function()
		require("todo-comments").setup({
			signs = true,
			keywords = {
				FIX = {
					icon = " ",
					color = "error",
					alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
				},
				TODO = { icon = " ", color = "info" },
				HACK = { icon = " ", color = "warning" },
				WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
			},
			colors = {
				error = { "LspDiagnosticsDefaultError", "ErrorMsg" },
				warning = { "LspDiagnosticsDefaultWarning", "WarningMsg" },
				info = { "LspDiagnosticsDefaultInformation", "MoreMsg" },
			},
		})
	end,
}
