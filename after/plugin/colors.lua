function ColorMyPencils(color)
  color = color
  vim.cmd.colorscheme(color)

  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalNC", { bg = "#0e0f17" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
  vim.api.nvim_set_hl(0, "String", { fg = "#f5fffe" })
  vim.api.nvim_set_hl(0, "@variable", { fg = "#26d1a6" })
  vim.api.nvim_set_hl(0, "@variable.field", { fg = "#647574" })
  -- set comments to be italic
  vim.api.nvim_set_hl(0, "Comment", { italic = true, fg = "#647574" })
  -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
  vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = "#0e0f17" })
  -- vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { bg = "#ff0000" })
  -- vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { bg = "#ff0000" })
end

ColorMyPencils("catppuccin")
