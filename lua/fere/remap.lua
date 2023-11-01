vim.g.mapleader = " "
vim.keymap.set("n", "<leader>v", ":NvimTreeToggle<CR>")
vim.keymap.set("n", "<C-s>", ':w<CR>zz')
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<leader>fi", "<cmd>!tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>ac", ":Copilot setup<CR> :Copilot panel<CR>")
vim.keymap.set("n", "<leader>ce", ":Copilot enable<CR>")
vim.keymap.set("n", "<leader>t", ":split<CR><C-w>J :resize 20<CR> :terminal<CR> i")
vim.keymap.set("n", "j", "jzzzv")
vim.keymap.set("n", "k", "kzzzv")
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
vim.keymap.set("t", "<C-t>", "<C-c>exit<CR><C-\\><C-n><C-w>c")
vim.keymap.set("i", "<C-s>", '<Esc>:w<CR>a')


-- remap yank to copy to clipboard
vim.keymap.set("n", "y", '"+y')
vim.keymap.set("v", "y", '"+y')
vim.keymap.set("n", "Y", '"+yg_')
vim.keymap.set("v", "Y", '"+yg_')
-- remap paste to paste from clipboard
vim.keymap.set("n", "p", '"+p')
vim.keymap.set("v", "p", '"+p')
vim.keymap.set("n", "P", '"+P')
vim.keymap.set("v", "P", '"+P')

-- remap change to delete to register 0
vim.keymap.set("n", "c", '"0c')
vim.keymap.set("v", "c", '"0c')
vim.keymap.set("n", "C", '"0C')
vim.keymap.set("v", "C", '"0C')

-- remap delete to register 0
vim.keymap.set("n", "d", '"0d')
vim.keymap.set("v", "d", '"0d')
vim.keymap.set("n", "D", '"0D')
vim.keymap.set("v", "D", '"0D')

-- remap change to delete to register 0
vim.keymap.set("n", "x", '"0x')
vim.keymap.set("v", "x", '"0x')
vim.keymap.set("n", "X", '"0X')
vim.keymap.set("v", "X", '"0X')

-- paste from register 0
vim.keymap.set("n", "<leader>p", '"0p')
vim.keymap.set("v", "<leader>p", '"0p')
vim.keymap.set("n", "<leader>P", '"0P')
vim.keymap.set("v", "<leader>P", '"0P')

-- move to start of line using F
vim.keymap.set("n", "F", "^")

vim.keymap.set("n", "<C-g>",
  function()
    local result = vim.treesitter.get_captures_at_cursor(0)
    print(vim.inspect(result))
  end,
  { noremap = true, silent = false }
)
