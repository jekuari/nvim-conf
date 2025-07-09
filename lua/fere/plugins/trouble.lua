return {
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
}
