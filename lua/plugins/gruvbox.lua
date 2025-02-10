-- convert packer import to Lazy
--   use { 'ellisonleao/gruvbox.nvim' }

return {
  'ellisonleao/gruvbox.nvim',
  -- commit = "73f009df5ed929a853244c413bb52c1d02c117ce",
  enabled = true,
  init = function()
    vim.cmd.colorscheme('gruvbox')
    -- vim.api.nvim_set_hl(0, 'NeoTreeGitAdded', {ctermbg='none'})
    -- vim.api.nvim_set_hl(0, 'NeoTreeGitConflict', {ctermbg='none'})
    -- vim.api.nvim_set_hl(0, 'NeoTreeGitModified', {ctermbg='none'})
  end,
  opts = {
    terminal_colors = true,
    undercurl = true,
    underline = true,
    bold = true,
    italic = {
      strings = true,
      emphasis = true,
      comments = true,
      operators = false,
      folds = true,
    },
    strikethrough = true,
    invert_selection = false,
    invert_signs = false,
    invert_tabline = false,
    invert_intend_guides = false,
    inverse = true, -- invert background for search, diffs, statuslines and errors
    contrast = "", -- can be "hard", "soft" or empty string
    palette_overrides = { },
    overrides = {},
    dim_inactive = false,
    transparent_mode = false,
  },
  priority = 10000,
}
