return {
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
        buftypes_to_ignore = {},   -- list of buffer types what should not be deleted from current session
        load_on_setup = true,
        theme_conf = { border = true },
        previewer = false,
      },
    }
  end
}
