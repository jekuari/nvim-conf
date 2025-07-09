return {
	"catppuccin/nvim",
	as = "catppuccin",
	config = function()
		function ColorMyPencils(color)
			color = color
			vim.cmd.colorscheme(color)

			vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
			vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
			vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
			vim.api.nvim_set_hl(0, "NormalNCFloat", { bg = "none" })
			-- telescope transparent
			vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })
			vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { bg = "none" })
			vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { bg = "none" })

			--nvim tree explorer transparent
			vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "none" })
			vim.api.nvim_set_hl(0, "NvimTreeNormalNC", { bg = "none" })
			vim.api.nvim_set_hl(0, "NvimTreeNormalFloat", { bg = "none" })

			-- lines dividing the sections transparent
			vim.api.nvim_set_hl(0, "VertSplit", { bg = "none" })
			vim.api.nvim_set_hl(0, "StatusLine", { bg = "none" })
			vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "none" })

			-- separators
			vim.api.nvim_set_hl(0, "VertSplit", { fg = "#647574" })

			-- dashboard
			vim.api.nvim_set_hl(0, "Header", { fg = "#92EFB1" })
			vim.api.nvim_set_hl(0, "menuitem", { fg = "#FFFFFF" })
			vim.api.nvim_set_hl(0, "menuicon", { fg = "#92EFB1" })
			vim.api.nvim_set_hl(0, "menukey", { fg = "#FFFFFF" })

			vim.api.nvim_set_hl(0, "String", { fg = "#f5fffe" })
			vim.api.nvim_set_hl(0, "@variable", { fg = "#26d1a6" })
			vim.api.nvim_set_hl(0, "@variable.field", { fg = "#647574" })
			-- set comments to be italic
			vim.api.nvim_set_hl(0, "@lsp.type.comment", { italic = true, fg = "#647574" })
			vim.api.nvim_set_hl(0, "@tag.tsx", { italic = true, fg = "#acf56c" })
			vim.api.nvim_set_hl(0, "@tag.builtin.tsx", { italic = true, fg = "#b8a0fa" })
			vim.api.nvim_set_hl(0, "@tag.attribute.tsx", { italic = true, fg = "#d9d89c" })
			vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = "#0e0f17" })

			--
		end

		ColorMyPencils("catppuccin")
	end,
}
