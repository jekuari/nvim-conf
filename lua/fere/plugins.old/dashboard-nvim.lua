return {
	"nvimdev/dashboard-nvim",
	event = "VimEnter",
	config = function()
		require("dashboard").setup({
			-- config
			theme = "doom", --  theme is doom and hyper default is hyper
			disable_move = false, --  default is false disable move keymap for hyper
			shortcut_type = "letter", --  shortcut type 'letter' or 'number'
			change_to_vcs_root = true, -- default is false,for open file in hyper mru. it will change to the root of vcs
			hide = {
				statusline = true, -- hide statusline default is true
				tabline = true, -- hide the tabline
				winbar = true, -- hide winbar
			},
			config = {
				center = {
					{
						icon = " ", --  
						icon_hl = "group",
						desc = "Restore Session",
						desc_hl = "group",
						key = "a",
						key_hl = "group",
						key_format = " [%s]", -- `%s` will be substituted with value of `key`
						action = require("auto-session").RestoreSession,
					},
					{
						icon = " ", --  
						icon_hl = "group",
						desc = "Search Session",
						desc_hl = "group",
						key = "b",
						key_hl = "group",
						key_format = " [%s]", -- `%s` will be substituted with value of `key`
						action = require("session-lens").search_session,
					},
					{
						icon = " ", --  
						icon_hl = "group",
						desc = "Recent Projects",
						desc_hl = "group",
						key = "1",
						key_hl = "group",
						key_format = " [%s]", -- `%s` will be substituted with value of `key`
						action = require("telescope.builtin").oldfiles,
					},
				},
				footer = {},
			},
			--[[ preview = {
  command       -- preview command
  file_path     -- preview file path
  file_height   -- preview file height
  file_width    -- preview file width
}, ]]
		})
	end,
	dependencies = { { "nvim-tree/nvim-web-devicons" } },
}
