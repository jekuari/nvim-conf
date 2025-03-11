---@class snacks.dashboard.Config
---@field enabled? boolean
---@field sections snacks.dashboard.Section
---@field formats table<string, snacks.dashboard.Text|fun(item:snacks.dashboard.Item, ctx:snacks.dashboard.Format.ctx):snacks.dashboard.Text>
return {
	enabled = true,
	width = 60,
	row = nil, -- dashboard position. nil for center
	col = nil, -- dashboard position. nil for center
	pane_gap = 4, -- empty columns between vertical panes
	autokeys = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", -- autokey sequence
	-- These settings are used by some built-in sections
	preset = {
		-- Defaults to a picker that supports `fzf-lua`, `telescope.nvim` and `mini.pick`
		---@type fun(cmd:string, opts:table)|nil
		pick = nil,
		-- Used by the `keys` section to show keymaps.
		-- Set your custom keymaps here.
		-- When using a function, the `items` argument are the default keymaps.
		---@type snacks.dashboard.Item[]
		keys = {
			{
				icon = { " ", hl = "menuicon" },
				key = "s",
				desc = { "Restore Session", hl = "menuitem" },
				section = "session",
			},
			{
				icon = { " ", hl = "menuicon" },
				key = "f",
				desc = { "Find File", hl = "menuitem" },
				action = ":lua Snacks.dashboard.pick('files')",
			},
			{
				icon = { " ", hl = "menuicon" },
				key = "n",
				desc = { "New File", hl = "menuitem" },
				action = ":ene | startinsert",
			},
			{
				icon = { " ", hl = "menuicon" },
				key = "g",
				desc = { "Find Text", hl = "menuitem" },
				action = ":lua Snacks.dashboard.pick('live_grep')",
			},
			{
				icon = { " ", hl = "menuicon" },
				key = "r",
				desc = { "Recent Files", hl = "menuitem" },
				action = ":lua Snacks.dashboard.pick('oldfiles')",
			},
			{
				icon = { " ", hl = "menuicon" },
				key = "c",
				desc = { "Config", hl = "menuitem" },
				action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
			},
			{
				icon = { " ", hl = "menuicon" },
				key = "L",
				desc = { "Lazy", hl = "menuitem" },
				action = ":Lazy",
				enabled = package.loaded.lazy ~= nil,
			},
			{
				icon = { " ", hl = "menuicon" },
				key = "q",
				desc = { "Quit", hl = "menuitem" },
				action = ":qa",
			},
		},
		-- Used by the `header` section
		header = [[
     ██╗███████╗██╗  ██╗██╗   ██╗ █████╗ ██████╗ ██╗
     ██║██╔════╝██║ ██╔╝██║   ██║██╔══██╗██╔══██╗██║
     ██║█████╗  █████╔╝ ██║   ██║███████║██████╔╝██║
██   ██║██╔══╝  ██╔═██╗ ██║   ██║██╔══██║██╔══██╗██║
╚█████╔╝███████╗██║  ██╗╚██████╔╝██║  ██║██║  ██║██║
 ╚════╝ ╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝]],
	},
	-- item field formatters
	formats = {
		icon = function(item)
			if item.file and item.icon == "file" or item.icon == "directory" then
				return M.icon(item.file, item.icon)
			end
			return { item.icon, width = 2, hl = "icon" }
		end,
		footer = { "%s", align = "center" },
		header = { "%s", align = "center", hl = "Header" },
		file = function(item, ctx)
			local fname = vim.fn.fnamemodify(item.file, ":~")
			fname = ctx.width and #fname > ctx.width and vim.fn.pathshorten(fname) or fname
			if #fname > ctx.width then
				local dir = vim.fn.fnamemodify(fname, ":h")
				local file = vim.fn.fnamemodify(fname, ":t")
				if dir and file then
					file = file:sub(-(ctx.width - #dir - 2))
					fname = dir .. "/…" .. file
				end
			end
			local dir, file = fname:match("^(.*)/(.+)$")
			return dir and { { dir .. "/", hl = "dir" }, { file, hl = "file" } } or { { fname, hl = "file" } }
		end,
	},
	sections = {
		{ section = "header" },
		{ section = "keys", gap = 1, padding = 1 },
		{ section = "startup" },
	},
}
