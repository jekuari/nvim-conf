return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").setup({
			-- A list of parser names, or "all" (the five listed parsers should always be installed)
			ensure_installed = {
				"bash",
				"typescript",
				"tsx",
				"graphql",
				"javascript",
				"rust",
				"go",
				"java",
				"c",
				"lua",
				"vim",
				"vimdoc",
				"query",
				"vue",
				"markdown",
				"markdown_inline",
			},
			sync_install = true,
			auto_install = true,
		})

		-- Incremental selection (replaces the removed nvim-treesitter module)
		local current_node = nil

		vim.keymap.set({ "n", "x" }, "<leader>k", function()
			if vim.fn.mode() == "n" then
				current_node = vim.treesitter.get_node()
				if not current_node then return end
				local sr, sc, er, ec = current_node:range()
				vim.api.nvim_win_set_cursor(0, { sr + 1, sc })
				vim.cmd("normal! v")
				vim.api.nvim_win_set_cursor(0, { er + 1, ec > 0 and ec - 1 or 0 })
			else
				if not current_node then return end
				local parent = current_node:parent()
				if not parent then return end
				current_node = parent
				local sr, sc, er, ec = current_node:range()
				vim.cmd("normal! \27")
				vim.api.nvim_win_set_cursor(0, { sr + 1, sc })
				vim.cmd("normal! v")
				vim.api.nvim_win_set_cursor(0, { er + 1, ec > 0 and ec - 1 or 0 })
			end
		end, { desc = "Treesitter: Init/Expand selection" })

		vim.keymap.set("x", "<leader>j", function()
			if not current_node then return end
			local child = current_node:child(0)
			if child then
				current_node = child
			end
			local sr, sc, er, ec = current_node:range()
			vim.cmd("normal! \27")
			vim.api.nvim_win_set_cursor(0, { sr + 1, sc })
			vim.cmd("normal! v")
			vim.api.nvim_win_set_cursor(0, { er + 1, ec > 0 and ec - 1 or 0 })
		end, { desc = "Treesitter: Shrink selection" })
	end,
}
