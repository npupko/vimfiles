return {
  enabled = false,
  'junegunn/fzf.vim',
  keys = {
    { '<c-P>', ':Files<CR>', desc = 'Find files' },
    { '<c-\\>', ':Buffers<CR>', desc = 'Find buffers' },
    { '<c-Enter>', ':History<CR>', desc = 'Find history' },
    { '<leader>p', ':Rg<CR>', desc = 'Find in project' },
    { '<localleader>m', ':Maps<CR>', desc = 'Find mappings' }
  },
  dependencies = {
    { 'junegunn/fzf', build = function() vim.fn['fzf#install']() end },
  },
  config = true
}
