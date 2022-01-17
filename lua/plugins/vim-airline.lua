vim.g.airline_powerline_fonts = 1
vim.g.airline_skip_empty_sections = 1
vim.g['airline#extensions#syntastic#enabled'] = 0
vim.g['airline#extensions#ctrlspace#enabled'] = 0
vim.g['airline#extensions#tmuxline#enabled'] = 0
vim.g['airline#extensions#wordcount#enabled'] = 0
vim.g['airline#extensions#keymap#enabled'] = 0
vim.g['airline#extensions#coc#enabled'] = 0
vim.g['airline#extensions#ale#enabled'] = 0
vim.g['airline#extensions#nerdtree_status'] = 0
-- Tabline
vim.g['airline#extensions#tabline#enabled'] = 0
vim.g['airline#extensions#tabline#show_close_button'] = 0
vim.g['airline#extensions#tabline#fnamemod'] = ':t'
vim.g['airline#extensions#tabline#show_buffers'] = 1
vim.g['airline#extensions#tabline#tab_min_count'] = 2

vim.cmd([[
let g:airline_filetype_overrides = {
  \ 'defx':  ['defx', '%{b:defx.paths[0]}'],
  \ 'gundo': [ 'Gundo', '' ],
  \ 'help':  [ 'Help', '%f' ],
  \ 'minibufexpl': [ 'MiniBufExplorer', '' ],
  \ 'nerdtree': [ get(g:, 'NERDTreeStatusline', 'NERD'), '' ],
  \ 'startify': [ 'startify', '' ],
  \ 'vim-plug': [ 'Plugins', '' ],
  \ 'vimfiler': [ 'vimfiler', '%{vimfiler#get_status_string()}' ],
  \ 'vimshell': ['vimshell','%{vimshell#get_status_string()}'],
  \ }
]])
