vim.g.mapleader = " "
vim.keymap.set("n", "<leader>v", ":NvimTreeToggle<CR>")
vim.keymap.set("n", "<C-s>", ':w<CR>zz')
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<leader>ac", ":Copilot setup<CR> :Copilot panel<CR>")
vim.keymap.set("n", "<leader>ce", ":Copilot enable<CR>")
vim.keymap.set("n", "<leader>t", ":split<CR><C-w>J :resize 20<CR> :terminal<CR> i")
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "j", "jzzzv")
vim.keymap.set("n", "k", "kzzzv")
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
vim.keymap.set("t", "<C-t>", "<C-c>exit<CR><C-\\><C-n><C-w>c")
vim.keymap.set("i", "<C-s>", '<Esc>:w<CR>a')
vim.keymap.set("n", "<leader>n", ":nohlsearch<CR>")
vim.keymap.set("n", "<leader>r", ":LspRestart<CR>")
vim.keymap.set("n", "<leader>l", ":SearchSession<CR>")
vim.keymap.set("i", "jk", "<Esc>")

-- tab navigation
vim.keymap.set("n", "<Tab>n", ":tabnew<CR>")
vim.keymap.set("n", "<Tab>h", ":tabprevious<CR>")
vim.keymap.set("n", "<Tab>l", ":tabnext<CR>")
vim.keymap.set("n", "<Tab>d", ":tabclose<CR>")

vim.keymap.set("n", "<C-g>",
  function()
    local result = vim.treesitter.get_captures_at_cursor(0)
    print(vim.inspect(result))
  end,
  { noremap = true, silent = false }
)

vim.keymap.set("n", "<leader>w", ":w<CR>")
-- <leader>o should vertically split the windows
vim.keymap.set("n", "<leader>o", ":vsplit<CR>")
-- <leader>i should horizontally split the windows
vim.keymap.set("n", "<leader>i", ":split<CR>")
-- <leader>q should close the current window
vim.keymap.set("n", "<leader>q", ":q<CR>")
-- <lesader>Q should close the current buffer
vim.keymap.set("n", "<leader>Q", ":bd<CR>")
-- <leader><leader>q should close neovim
vim.keymap.set("n", "<leader><leader>q", ":qa<CR>")
