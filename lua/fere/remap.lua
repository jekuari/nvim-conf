vim.g.mapleader = " "
vim.keymap.set("n", "<leader>v", ":NvimTreeToggle<CR>", { desc = "Toggle NvimTree" })
vim.keymap.set("n", "<C-s>", ':w<CR>zz', { desc = "Save file" })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })
vim.keymap.set("n", "<leader>ac", ":Copilot panel<CR>", { desc = "Copilot panel" })
vim.keymap.set("n", "<leader>ce", ":Copilot enable<CR>", { desc = "Copilot enable" })
vim.keymap.set("n", "<leader>t", ":split<CR><C-w>J :resize 20<CR> :terminal<CR> i", { desc = "Open terminal" })
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })
vim.keymap.set("n", "j", "jzzzv")
vim.keymap.set("n", "k", "kzzzv")
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
vim.keymap.set("t", "<C-t>", "<C-c>exit<CR><C-\\><C-n><C-w>c")
vim.keymap.set("i", "<C-s>", '<Esc>:w<CR>a')
vim.keymap.set("n", "<leader>n", ":nohlsearch<CR>", { desc = "Clear highlights" })
vim.keymap.set("n", "<leader>r", ":LspRestart<CR>", { desc = "Restart LSP" })
vim.keymap.set("n", "<leader>l", ":SearchSession<CR>", { desc = "Search session" })
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

vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save file" })
-- <leader>o should vertically split the windows
vim.keymap.set("n", "<leader>o", ":vsplit<CR>", { desc = "Vertical split" })
-- <leader>i should horizontally split the windows
vim.keymap.set("n", "<leader>i", ":split<CR>", { desc = "Horizontal split" })
-- <leader>q should close the current window
vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "Close window" })
-- <lesader>Q should close the current buffer
vim.keymap.set("n", "<leader>Q", ":bd<CR>", { desc = "Close buffer" })
-- <leader><leader>q should close neovim
vim.keymap.set("n", "<leader><leader>q", ":qa<CR>", { desc = "Close neovim" })


-- <leader>po should insert a new line in between the previous and current character
vim.keymap.set("n", "<leader>po", "i<CR><Esc>O", { desc = "Write inside current keys" })
-- <C-o> in insert mode should do the same
vim.keymap.set("i", "<C-i>", "<Esc>i<CR><Esc>O", { desc = "Write inside current keys" })

local function get_function_node_types(filetype)
  -- Map each filetype to its relevant function-like node types
  local filetype_map = {
    typescript = { "function_declaration", "method_definition", "arrow_function", "function_expression" },
    tsx = { "function_declaration", "method_definition", "arrow_function", "function_expression" },
    javascript = { "function_declaration", "method_definition", "arrow_function", "function_expression" },
    vue = { "arrow_function", "function_expression" },
    jsx = { "function_declaration", "method_definition", "arrow_function", "function_expression" },
    go = { "function_declaration", "method_declaration" },
    lua = { "function_declaration" },
    rust = { "function_item", "impl_item" },
    c = { "function_definition" },
    ["c++"] = { "function_definition", "method_declaration" },
    cs = { "method_declaration", "function_declaration" }, -- C#
    python = { "function_definition", "lambda" }
  }

  -- Return the node types for the given filetype
  return filetype_map[filetype] or {}
end
-- <leader>p should select the method_definition, lexical_declaration or function_declaration
--local function get_treesitter_parser_name(filetype)
local function get_treesitter_parser_name(filetype)
  local filetype_to_parser = {
    -- Standard mappings
    lua = "lua",
    javascript = "tsx",
    typescript = "typescript",
    tsx = "tsx",
    javascriptreact = "tsx",
    typescriptreact = "tsx",
    vue = "vue",
    html = "html",
    css = "css",
    json = "json",
    go = "go",
    rust = "rust",
    c = "c",
    cpp = "cpp",
    cxx = "cpp",
    objc = "cpp",
    objcpp = "cpp",
    java = "java",
    python = "python",
    ruby = "ruby",
    php = "php",
  }

  -- Get the Tree-sitter parser name for the given filetype
  local parser_name = filetype_to_parser[filetype]
  return parser_name or "unknown"
end

local function find_surrounding_function_node()
  local file_type = get_treesitter_parser_name(vim.bo.filetype)
  local parser = vim.treesitter.get_parser(0, file_type)
  local root = parser:parse()[1]:root()
  local node_types = get_function_node_types(file_type)
  local cursor_row, cursor_col = unpack(vim.api.nvim_win_get_cursor(0))
  cursor_row = cursor_row - 1 -- Convert to 0-based index

  -- Build the Treesitter query dynamically based on the filetype
  local query_string = ""
  for _, node_type in ipairs(node_types) do
    query_string = query_string .. string.format("(%s) @target ", node_type)
  end

  if query_string == "" then
    print("No function declarations found for this filetype.")
    return nil
  end

  local query = vim.treesitter.query.parse(file_type, query_string)

  -- Find the function node that surrounds the cursor position
  local surrounding_node = nil
  for _, match, _ in query:iter_matches(root, 0) do
    local node = match[1]

    -- Handle nested local_declaration for Lua
    if node:type() == "local_declaration" then
      for child in node:iter_children() do
        if child:type() == "function_declaration" then
          node = child
          break
        end
      end
    end

    local start_row, start_col, _ = node:start()
    local end_row, end_col, _ = node:end_()

    -- Check if the cursor is within this function node
    if cursor_row >= start_row and cursor_row <= end_row then
      -- Ensure the node contains the cursor horizontally too
      if cursor_row == start_row and cursor_col < start_col then
        goto continue
      elseif cursor_row == end_row and cursor_col > end_col then
        goto continue
      end

      -- Update the surrounding node if it's a better fit
      if surrounding_node == nil or start_row > surrounding_node:start() then
        surrounding_node = node
      end
    end
    ::continue::
  end

  return surrounding_node
end
local function center_cursor()
  vim.cmd('normal! zz')
end

function GoToSurroundingFunctionStart()
  local node = find_surrounding_function_node()
  if node then
    local start_row, start_col, _ = node:start()
    vim.api.nvim_win_set_cursor(0, { start_row + 1, start_col })
    center_cursor()
  else
    print("No function found surrounding the cursor")
  end
end

function GoToSurroundingFunctionEnd()
  local node = find_surrounding_function_node()
  if node then
    local end_row, end_col, _ = node:end_()
    vim.api.nvim_win_set_cursor(0, { end_row + 1, end_col })
    center_cursor()
  else
    print("No function found surrounding the cursor")
  end
end

function SelectSurroundingFunction()
  local node = find_surrounding_function_node()
  if node then
    local start_row, start_col, _ = node:start()
    local end_row, end_col, _ = node:end_()

    -- Move cursor to the start of the function
    vim.api.nvim_win_set_cursor(0, { start_row + 1, start_col })

    -- Enter visual mode and select to the end of the function
    vim.cmd('normal! v')
    vim.api.nvim_win_set_cursor(0, { end_row + 1, end_col })
    center_cursor()
  else
    print("No function found surrounding the cursor")
  end
end

vim.keymap.set('n', '<leader>pfs', GoToSurroundingFunctionStart,
  { noremap = true, silent = true, desc = "Go to surrounding function start" })
vim.keymap.set('n', '<leader>pfe', GoToSurroundingFunctionEnd,
  { noremap = true, silent = true, desc = "Go to surrounding function end" })

-- maybe this gives the definition
vim.keymap.set('n', '<leader>pfv', SelectSurroundingFunction,
  { noremap = true, silent = true, desc = "Select surrounding function" })

local function get_declaration_node_types(filetype)
  -- Map each filetype to its relevant declaration-like node types
  local filetype_map = {
    typescript = { "lexical_declaration", "variable_declaration" },
    tsx = { "lexical_declaration", "variable_declaration" },
    vue = { "lexical_declaration", "variable_declarator", },
    javascript = { "variable_declaration" },
    jsx = { "variable_declaration" },
    go = { "variable_declaration" },
    lua = { "variable_declaration" },
    rust = { "let_declaration" },
    c = { "variable_declaration" },
    ["c++"] = { "variable_declaration" },
    cs = { "variable_declaration" },
    python = { "variable_declaration" }
  }

  -- Return the node types for the given filetype
  return filetype_map[filetype] or {}
end

local function find_surrounding_declaration_node()
  local file_type = get_treesitter_parser_name(vim.bo.filetype)
  local parser = vim.treesitter.get_parser(0, file_type)
  local root = parser:parse()[1]:root()
  local node_types = get_declaration_node_types(file_type)
  local cursor_row, cursor_col = unpack(vim.api.nvim_win_get_cursor(0))
  cursor_row = cursor_row - 1 -- Convert to 0-based index

  -- Build the Treesitter query dynamically based on the filetype
  local query_string = ""
  for _, node_type in ipairs(node_types) do
    query_string = query_string .. string.format("(%s) @target ", node_type)
  end

  if query_string == "" then
    print("No declaration nodes found for this filetype.")
    return nil
  end

  local query = vim.treesitter.query.parse(file_type, query_string)

  -- Find the declaration node that surrounds the cursor position
  local surrounding_node = nil
  for _, match, _ in query:iter_matches(root, 0) do
    local node = match[1]

    local start_row, start_col, _ = node:start()
    local end_row, end_col, _ = node:end_()

    -- Check if the cursor is within this declaration node
    if cursor_row >= start_row and cursor_row <= end_row then
      -- Ensure the node contains the cursor horizontally too
      if cursor_row == start_row and cursor_col < start_col then
        goto continue
      elseif cursor_row == end_row and cursor_col > end_col then
        goto continue
      end

      -- Update the surrounding node if it's a better fit
      if surrounding_node == nil or start_row > surrounding_node:start() then
        surrounding_node = node
      end
    end
    ::continue::
  end

  return surrounding_node
end

function GoToSurroundingDeclarationStart()
  local node = find_surrounding_declaration_node()
  if node then
    local start_row, start_col, _ = node:start()
    vim.api.nvim_win_set_cursor(0, { start_row + 1, start_col })
    center_cursor()
  else
    print("No declaration found surrounding the cursor")
  end
end

function GoToSurroundingDeclarationEnd()
  local node = find_surrounding_declaration_node()
  if node then
    local end_row, end_col, _ = node:end_()
    vim.api.nvim_win_set_cursor(0, { end_row + 1, end_col })
    center_cursor()
  else
    print("No declaration found surrounding the cursor")
  end
end

function SelectSurroundingDeclaration()
  local node = find_surrounding_declaration_node()
  if node then
    local start_row, start_col, _ = node:start()
    local end_row, end_col, _ = node:end_()

    -- Move cursor to the start of the declaration
    vim.api.nvim_win_set_cursor(0, { start_row + 1, start_col })

    -- Enter visual mode and select to the end of the declaration
    vim.cmd('normal! v')
    vim.api.nvim_win_set_cursor(0, { end_row + 1, end_col })
    center_cursor()
  else
    print("No declaration found surrounding the cursor")
  end
end

vim.keymap.set('n', '<leader>pds', GoToSurroundingDeclarationStart,
  { noremap = true, silent = true, desc = "Go to surrounding declaration start" })
vim.keymap.set('n', '<leader>pde', GoToSurroundingDeclarationEnd,
  { noremap = true, silent = true, desc = "Go to surrounding declaration end" })
vim.keymap.set('n', '<leader>pdv', SelectSurroundingDeclaration,
  { noremap = true, silent = true, desc = "Select surrounding declaration" })
