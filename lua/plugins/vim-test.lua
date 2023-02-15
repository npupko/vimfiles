-- vim.api.nvim_set_keymap('n', '<leader>tn', ':TestNearest<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>tf', ':TestFile<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>ts', ':TestSuite<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>tl', ':TestLast<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>tg', ':TestVisit<CR>', { noremap = true, silent = true })
return {
  'janko-m/vim-test',
  keys = {
    { '<leader>tn', ':TestNearest<CR>' },
    { '<leader>tf', ':TestFile<CR>' },
    { '<leader>ts', ':TestSuite<CR>' },
    { '<leader>tl', ':TestLast<CR>' },
    { '<leader>tg', ':TestVisit<CR>' },
  },
  config = function()
    vim.g['test#strategy'] = "neovim"
    vim.g['test#runner_commands'] = {'RSpec'}
    -- vim.g['test#ruby#rspec#executable'] = 'bundle exec rspec'
    vim.g['test#ruby#rspec#executable'] = 'docker-compose run --rm backend bundle exec rspec'
  end,
}
