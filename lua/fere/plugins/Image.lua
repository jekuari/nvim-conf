return {
	"3rd/image.nvim",
	dependencies = { "luarocks.nvim" },
	config = function()
		require("image").setup({
			backend = "kitty",
			integrations = {
				markdown = {
					enabled = true,
					clear_in_insert_mode = false,
					download_remote_images = true,
					only_render_image_at_cursor = false,
					filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
				},
				neorg = {
					enabled = true,
					clear_in_insert_mode = false,
					download_remote_images = true,
					only_render_image_at_cursor = false,
					filetypes = { "norg" },
				},
				html = {
					enabled = false,
				},
				css = {
					enabled = false,
				},
			},
			max_width = nil,
			max_height = nil,
			max_width_window_percentage = nil,
			max_height_window_percentage = 50,
			window_overlap_clear_enabled = false, -- toggles images when windows are overlapped
			window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
			editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
			tmux_show_only_in_active_window = true,
			hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" }, -- render image files as images when opened
		})

		-- Open image in a floating window
		local win = nil
		local buf = nil
		local image = nil
		vim.keymap.set("n", "<leader>m", function()
			if win or buf or image then
				-- check if the buf exists
				local early_exit = true
				if vim.api.nvim_buf_is_valid(buf) then
					vim.api.nvim_buf_delete(buf, { force = true })
				elseif buf then
					early_exit = false
				end

				if vim.api.nvim_win_is_valid(win) then
					vim.api.nvim_win_close(win, true)
				elseif win then
					early_exit = not (early_exit == false)
				end

				if image then
					image:clear()
				end
				buf = nil
				win = nil
				image = nil

				if early_exit then
					return
				end
			end

			local file_name = vim.fn.expand("%:p")

			buf = vim.api.nvim_create_buf(false, true)
			vim.api.nvim_buf_set_option(buf, "modifiable", false)
			vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
			local width = vim.api.nvim_get_option("columns")
			local height = vim.api.nvim_get_option("lines")

			local win_width = math.ceil(width * 0.5)
			local win_height = math.ceil(height * 0.5)
			local row = math.ceil((height - win_height) / 2)
			local col = math.ceil((width - win_width) / 2)
			local border_chars = { "┌", "─", "┐", "│", "┘", "─", "└", "│" }
			local opts = {
				style = "minimal",
				relative = "editor",
				width = win_width,
				height = win_height,
				row = row,
				col = col,
				border = border_chars,
			}
			win = vim.api.nvim_open_win(buf, true, opts)

			image = require("image").from_file(file_name, {
				window = win,
				buffer = buf, -- optional, binds image to a buffer (paired with window binding)
				-- with_virtual_padding = true, -- optional, pads vertically with extmarks, defaults to false

				-- geometry (optional)
				height = win_height, -- optional, height of the image
				width = win_width, -- optional, width of the image
				x = 1, -- optional, x offset of the image
				y = 1, -- optional, y offset of the image
			})
			-- use image:move(x, y) to move the image to the center of the window
			--[[ local image_width = image.image_width
      local image_height = image.image_height

      local x = math.ceil((win_width - image_width) / 2)
      local y = math.ceil((win_height - image_height) / 2) ]]

			image:render()
			-- image:move(x, y)
		end, { noremap = true, silent = true, desc = "Open image in a floating window" })
	end,
}
