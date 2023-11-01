-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use('wbthomason/packer.nvim')

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.2',
    -- or                            , branch = '0.1.x',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }

  use { "bluz71/vim-moonfly-colors", as = "moonfly" }

  use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })

  use('theprimeagen/harpoon')

  use('mbbill/undotree')

  use('tpope/vim-fugitive')
  use { "catppuccin/nvim", as = "catppuccin" }

  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },             -- Required
      { 'williamboman/mason.nvim' },           -- Optional
      { 'williamboman/mason-lspconfig.nvim' }, -- Optional

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },     -- Required
      { 'hrsh7th/cmp-nvim-lsp' }, -- Required
      { 'L3MON4D3/LuaSnip' },     -- Required
    }
  }

  use("nvim-tree/nvim-tree.lua")

  use("nvim-tree/nvim-web-devicons")

  use("stevearc/dressing.nvim")

  use({
    "ziontee113/icon-picker.nvim",
    config = function()
      require("icon-picker").setup({
        disable_legacy_commands = true
      })
    end,
  })

  use({
    "roobert/tailwindcss-colorizer-cmp.nvim",
    config = function()
      require("tailwindcss-colorizer-cmp").setup({
        color_square_width = 2,
      })
    end
  })

  use('jose-elias-alvarez/null-ls.nvim')
  use('MunifTanjim/prettier.nvim')

  use('christoomey/vim-tmux-navigator')

  use('vim-airline/vim-airline')
  use('vim-airline/vim-airline-themes')

  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }
  use("folke/tokyonight.nvim")
  use { "themaxmarchuk/tailwindcss-colors.nvim" }

  use("mlaursen/vim-react-snippets")
  use('SirVer/ultisnips')
  use('honza/vim-snippets')

  use('chentoast/marks.nvim')
end)
