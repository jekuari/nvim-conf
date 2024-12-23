return {
  'smoka7/hop.nvim',
  version = "*",
  opts = {
    keys = 'etovxqpdygfblzhckisuran'
  },
  config = function()
    local hop = require('hop')
    hop.setup { keys = "etovxqpdygfblzhckisuranñ" }
    vim.keymap.set("n", "<leader>h", ":HopAnywhere<CR>", {
      desc = 'Hop anywhere'
    })
    vim.keymap.set("n", "ñ", ":HopWord<CR>", {
      desc = 'Hop word'
    })
    vim.keymap.set("n", "<leader>{", function()
      hop.hint_words()
    end, {
      desc = 'Hop words'
    })
  end
}
