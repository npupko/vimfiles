vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
-- vim.keymap.set('i', '<S-Tab>', 'copilot#Accept("<CR>")', { silent = true, expr = true })
-- imap <expr> <Plug>(vimrc:copilot-dummy-map) copilot#Accept("\<Tab>")

vim.keymap.set('i', '<M-\\>', '<Plug>(copilot-dismiss)', { silent = true })
