require("lazy").setup({
  { 'nvim-lua/plenary.nvim' },
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.4',
  },
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  'nvim-lua/plenary.nvim',
  'ThePrimeagen/harpoon',
  'mbbill/undotree',
  'tpope/vim-fugitive',
  { "catppuccin/nvim",                  as = "catppuccin" },
  { 'williamboman/mason.nvim' },
  { 'williamboman/mason-lspconfig.nvim' },

  { 'VonHeikemen/lsp-zero.nvim',        branch = 'v3.x' },
  { 'neovim/nvim-lspconfig' },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/nvim-cmp' },
  { 'L3MON4D3/LuaSnip' },
  "nvim-tree/nvim-tree.lua",
  "nvim-tree/nvim-web-devicons",
  {
    "ziontee113/icon-picker.nvim",
    config = function()
      require("icon-picker").setup({
        disable_legacy_commands = true
      })
    end,
  },
  {
    "roobert/tailwindcss-colorizer-cmp.nvim",
    config = function()
      require("tailwindcss-colorizer-cmp").setup({
        color_square_width = 2,
      })
    end
  },
  'jose-elias-alvarez/null-ls.nvim',
  'MunifTanjim/prettier.nvim',
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  },
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  },
  "folke/tokyonight.nvim",
  "themaxmarchuk/tailwindcss-colors.nvim",
  "mlaursen/vim-react-snippets",
  'SirVer/ultisnips',
  'honza/vim-snippets',
  'chentoast/marks.nvim',
  'christoomey/vim-tmux-navigator',
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup(
        {
          panel = {
            enabled = true,
            auto_refresh = false,
            keymap = {
              jump_prev = "[[",
              jump_next = "]]",
              accept = "<CR>",
              refresh = "gr",
              open = "<M-CR>"
            },
            layout = {
              position = "bottom", -- | top | left | right
              ratio = 0.4
            },
          },
          suggestion = {
            enabled = true,
            auto_trigger = true,
            debounce = 75,
            keymap = {
              -- accept use shift + <tab>
              accept = "<C-d>",
              accept_word = false,
              accept_line = false,
              next = "<M-]>",
              prev = "<M-[>",
              dismiss = "<C-]>",
            },
          },
          copilot_node_command = 'node', -- Node.js version must be > 16.x
          server_opts_overrides = {},
        }
      )
    end,
  },
  {
    'rmagatti/session-lens',
    requires = { 'rmagatti/auto-session', 'nvim-telescope/telescope.nvim' },
    config = function()
      require('session-lens').setup({
      })
    end
  },
  {
    'rmagatti/auto-session',
    config = function()
      require("auto-session").setup {
        log_level = "error",
        auto_session_suppress_dirs = { "~/Projects" },
        auto_save_enabled = true,
        auto_restore_enabled = false,
        pre_save_cmds = { function() vim.cmd("NvimTreeClose") end },
        post_save_cmds = { function() vim.cmd("NvimTreeOpen") end },
        post_restore_cmds = { function() vim.cmd("NvimTreeOpen") end },
        session_lens = {
          -- If load_on_setup is set to false, one needs to eventually call `require("auto-session").setup_session_lens()` if they want to use session-lens.
          buftypes_to_ignore = {}, -- list of buffer types what should not be deleted from current session
          load_on_setup = true,
          theme_conf = { border = true },
          previewer = false,
        },
      }
    end
  },
  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      require('dashboard').setup {
        -- config
        theme = 'doom',            --  theme is doom and hyper default is hyper
        disable_move = false,      --  default is false disable move keymap for hyper
        shortcut_type = "letter",  --  shortcut type 'letter' or 'number'
        change_to_vcs_root = true, -- default is false,for open file in hyper mru. it will change to the root of vcs
        hide = {
          statusline = true,       -- hide statusline default is true
          tabline = true,          -- hide the tabline
          winbar = true            -- hide winbar
        },
        config = {
          center = {
            {
              icon = ' ', --  
              icon_hl = 'group',
              desc = 'Restore Session',
              desc_hl = 'group',
              key = 'a',
              key_hl = 'group',
              key_format = ' [%s]', -- `%s` will be substituted with value of `key`
              action = require("auto-session").RestoreSession,
            },
            {
              icon = ' ', --  
              icon_hl = 'group',
              desc = 'Recent Projects',
              desc_hl = 'group',
              key = '1',
              key_hl = 'group',
              key_format = ' [%s]', -- `%s` will be substituted with value of `key`
              action = require('telescope.builtin').oldfiles,
            },
          },
          footer = {},
        }
        --[[ preview = {
  command       -- preview command
  file_path     -- preview file path
  file_height   -- preview file height
  file_width    -- preview file width
}, ]]
      }
    end,
    dependencies = { { 'nvim-tree/nvim-web-devicons' } }
  }
})
