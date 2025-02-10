return {
  'sainnhe/everforest',
  enabled = false,
  priority = 1,
  init = function()
    vim.cmd.colorscheme('everforest')
    -- vim.api.nvim_set_hl(0, 'NeoTreeGitAdded', {ctermbg='none'})
    -- vim.api.nvim_set_hl(0, 'NeoTreeGitConflict', {ctermbg='none'})
    -- vim.api.nvim_set_hl(0, 'NeoTreeGitModified', {ctermbg='none'})
  end,
}
