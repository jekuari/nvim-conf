local dashboard_config = require("fere.configurations.dashboard")
return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		bigfile = { enabled = true },
		dashboard = dashboard_config,
		indent = { enabled = true },
		input = { enabled = true },
		notifier = {
			enabled = true,
			timeout = 3000,
		},
		quickfile = { enabled = true },
		scroll = {
			enabled = true,
		},
		statuscolumn = { enabled = true },
		words = { enabled = true },
		animate = {
			---@class snacks.animate.Config
			---@field easing? snacks.animate.easing|snacks.animate.easing.Fn
			{
				---@type snacks.animate.Duration|number
				duration = { step = 5, total = 100 },
				easing = "linear",
				fps = 60, -- frames per second. Global setting for all animations
			},
		},
	},
}
