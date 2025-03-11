return {
	"nvim-tree/nvim-tree.lua",
	lazy = false,
	priority = 1010,
	config = function()
		-- disable netrw at the very start of your init.lua
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		-- set termguicolors to enable highlight groups
		vim.opt.termguicolors = true

		-- OR setup with some options
		require("nvim-tree").setup({
			sort_by = "case_sensitive",
			view = {
				width = 30,
			},
			renderer = {
				group_empty = true,
			},
			filters = {
				dotfiles = true,
			},
			on_attach = function(bufnr)
				local api = require("nvim-tree.api")

				local function opts(desc)
					return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
				end

				-- default mappings
				api.config.mappings.default_on_attach(bufnr)

				-- custom mappings
				vim.keymap.set("n", "<C-d>", api.tree.change_root_to_node, opts("Up"), {
					desc = "Change root to node",
				})
				vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"), {
					desc = "Toggle help",
				})
				vim.keymap.set("n", "<C-s>", api.tree.change_root_to_parent, opts("Help"), {
					desc = "Change root to parent",
				})
			end,
		})

		vim.keymap.set("n", "<leader>v", require("nvim-tree.api").tree.toggle, { desc = "Toggle NvimTree" })
	end,
}
