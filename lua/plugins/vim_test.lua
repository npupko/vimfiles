vim.api.nvim_set_keymap('n', '<leader>tn', ':TestNearest<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>tf', ':TestFile<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ts', ':TestSuite<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>tl', ':TestLast<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>tg', ':TestVisit<CR>', { noremap = true, silent = true })

-- vim.g['test#strategy'] = "neovim"
vim.g['test#strategy'] = "kitty"
