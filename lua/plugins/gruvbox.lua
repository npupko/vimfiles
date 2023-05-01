-- convert packer import to Lazy
--   use { 'ellisonleao/gruvbox.nvim' }

return {
  'ellisonleao/gruvbox.nvim',
  commit = "73f009df5ed929a853244c413bb52c1d02c117ce",
  enabled = true,
  init = function()
    vim.cmd([[colorscheme gruvbox]])
    -- vim.api.nvim_set_hl(0, 'NeoTreeGitAdded', {ctermbg='none'})
    -- vim.api.nvim_set_hl(0, 'NeoTreeGitConflict', {ctermbg='none'})
    -- vim.api.nvim_set_hl(0, 'NeoTreeGitModified', {ctermbg='none'})
  end,
  opts = {
    inverse = true,
    contrast = "",
    invert_selection = false,
    transparent_mode = true,
    overrides = {
      -- NeoTreeGitModified = {bg = "#ff99000"}
      -- ["@class"] = { link = "@constructor" },
      -- ["@decorator"] = { link = "Identifier" },
      -- ["@enum"] = { link = "@constructor" },
      -- ["@enumMember"] = { link = "Constant" },
      -- ["@event"] = { link = "Identifier" },
      -- ["@interface"] = { link = "Identifier" },
      -- ["@modifier"] = { link = "Identifier" },
      -- ["@regexp"] = { link = "SpecialChar" },
      -- ["@struct"] = { link = "@constructor" },
      -- ["@typeParameter"] = { link = "Type" },
    }
  },
  priority = 10000,
}
