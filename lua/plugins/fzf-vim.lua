-- if not pcall(require, "fzf.vim") then
--   return
-- end
--
vim.keymap.set('n', '<c-P>', ':Files<CR>')
vim.keymap.set('n', '<c-\\>', ':Buffers<CR>')
vim.keymap.set('n', '<c-Enter>', ':History<CR>')
vim.keymap.set('n', '<leader>p', ':Rg<CR>')
vim.keymap.set('n', '<localleader>m', ':Maps<CR>')
