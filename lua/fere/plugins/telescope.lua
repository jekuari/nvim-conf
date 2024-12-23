return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.4',
  config = function()
    local builtin = require('telescope.builtin')
    local previewers = require('telescope.previewers')

    local new_maker = function(filepath, bufnr, opts)
      opts = opts or {}

      filepath = vim.fn.expand(filepath)
      vim.loop.fs_stat(filepath, function(_, stat)
        if not stat then return end
        if stat.size > 100000 then
          return
        else
          previewers.buffer_previewer_maker(filepath, bufnr, opts)
        end
      end)
    end

    require('telescope').setup {
      defaults = {
        buffer_previewer_maker = new_maker,
      }
    }

    vim.keymap.set('n', '<leader>f', builtin.find_files, {
      desc = 'Find files'
    })
    vim.keymap.set('n', '<leader>g', builtin.git_files, {
      desc = 'Find git files'
    })
    -- vim.keymap.set('n', '<leader>s', function()
    --  builtin.grep_string({ search = vim.fn.input("Grep > ") });
    -- end)
    -- <leader>l to open live_grep
    vim.keymap.set('n', '<leader>s', builtin.live_grep, {
      desc = 'Live grep'
    })
  end
}
