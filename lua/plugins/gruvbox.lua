-- convert packer import to Lazy
--   use { 'ellisonleao/gruvbox.nvim' }

return {
  'ellisonleao/gruvbox.nvim',
  enabled = false,
  init = function()
    vim.cmd([[colorscheme gruvbox]])
    vim.api.nvim_set_hl(0, 'NeoTreeGitAdded', {bg='none'})
    vim.api.nvim_set_hl(0, 'NeoTreeGitConflict', {bg='none'})
  end,
  opts = {
    inverse = true,
    invert_selection = false,
    overrides = {
      -- NeoTreeGitModified = {bg = "#ff99000"}
    }
  },
  priority = 10000,
}
