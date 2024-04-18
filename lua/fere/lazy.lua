require("lazy").setup({
  { 'nvim-lua/plenary.nvim' },
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.4',
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "windwp/nvim-ts-autotag"
    }
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
  },
  'mbbill/undotree',
  'tpope/vim-fugitive',
  { "catppuccin/nvim",                  as = "catppuccin" },
  { 'williamboman/mason.nvim' },
  { 'williamboman/mason-lspconfig.nvim' },

  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    dependencies = { 'neovim/nvim-lspconfig' }
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },
  { 'hrsh7th/cmp-nvim-lsp' },
  {
    "roobert/tailwindcss-colorizer-cmp.nvim",
    config = function()
      require("tailwindcss-colorizer-cmp").setup({
        color_square_width = 2,
      })
    end
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer", -- source for text in buffer
      "hrsh7th/cmp-path",   -- source for file system paths
      {
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = "make install_jsregexp",
      },
      "saadparwaiz1/cmp_luasnip",     -- for autocompletion
      "rafamadriz/friendly-snippets", -- useful snippets
      "onsails/lspkind.nvim",         -- vs-code like pictograms

    },
    config = function()
      local cmp = require('cmp')

      local lspkind = require('lspkind')

      require("luasnip.loaders.from_vscode").load()

      cmp.setup({
        completion = {
          completeopt = "menu,menuone,preview,noselect",
        },
        snippet = { -- configure how nvim-cmp interacts with snippet engine
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-m>'] = cmp.mapping.select_prev_item(),
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-i>'] = cmp.mapping.scroll_docs(4),
          ['<C-o>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.close(),
          ['<C-y>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
          }),
        }),
        -- sources for autocompletion
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
          { name = 'path' },
        }),

        -- configure lspkind for vs-code like pictograms in completion menu
        formatting = {
          format = lspkind.cmp_format({
            maxwidth = 50,
            ellipsis_char = "...",
            before = function(entry, vim_item)
              return require("tailwindcss-colorizer-cmp").formatter(entry, vim_item)
            end
          }),
        },
      })
    end
  },
  "nvim-tree/nvim-tree.lua",
  "nvim-tree/nvim-web-devicons",
  'jose-elias-alvarez/null-ls.nvim',
  'MunifTanjim/prettier.nvim',
  {
    "ziontee113/icon-picker.nvim",
    config = function()
      require("icon-picker").setup({ disable_legacy_commands = true })
    end,
  },
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
  { "stevearc/dressing.nvim", event = "VeryLazy" },
  {
    'rmagatti/auto-session',
    config = function()
      require("auto-session").setup {
        log_level = "error",
        auto_session_allowed_dirs = { "~/Projects", "~/.config" },
        auto_save_enabled = true,
        auto_restore_enabled = false,
        auto_session_use_git_branch = true,
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
              desc = 'Search Session',
              desc_hl = 'group',
              key = 'b',
              key_hl = 'group',
              key_format = ' [%s]', -- `%s` will be substituted with value of `key`
              action = require("session-lens").search_session,
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
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufRead", "BufNewFile" },
    config = function()
      require('gitsigns').setup()
    end
  },
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
    config = function()
      require("trouble").setup {
        auto_preview = false,
        auto_fold = true,
        auto_close = true,
        auto_loc_list = true,
        auto_loclist = true,
        signs = {
          error = "",
          warning = "",
          hint = "",
          information = "",
          other = "﫠",
        },
        use_lsp_diagnostic_signs = true,
      }
    end,
  },
  {
    "folke/todo-comments.nvim",
    event = "BufRead",
    config = function()
      require("todo-comments").setup {
        signs = true,
        keywords = {
          FIX = {
            icon = " ",
            color = "error",
            alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
          },
          TODO = { icon = " ", color = "info" },
          HACK = { icon = " ", color = "warning" },
          WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        },
        colors = {
          error = { "LspDiagnosticsDefaultError", "ErrorMsg" },
          warning = { "LspDiagnosticsDefaultWarning", "WarningMsg" },
          info = { "LspDiagnosticsDefaultInformation", "MoreMsg" },
        },
      }
    end,
  },
})
