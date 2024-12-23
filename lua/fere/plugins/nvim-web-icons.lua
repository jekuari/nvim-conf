return {
  "nvim-tree/nvim-web-devicons",
  config = function()
    local opts = { noremap = true, silent = true }

    vim.keymap.set("n", "<Leader><Leader>i", "<cmd>IconPickerNormal<cr>", opts, {
      desc = "Open icon picker"
    })
    vim.keymap.set("n", "<Leader><Leader>y", "<cmd>IconPickerYank<cr>", opts, {
      desc = "Yank icon"
    }) --> Yank the selected icon into register
    vim.keymap.set("i", "<C-9>", "<cmd>IconPickerInsert<cr>", opts, {
      desc = "Insert icon"
    })
  end
}
