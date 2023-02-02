return {
  'tpope/vim-fugitive',
  config = function() 
    vim.keymap.set('n', '<leader>fh', "<cmd>0Gclog<CR>")
  end
}
