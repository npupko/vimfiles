" vim/neovim config used by Nikita Pupko
" Author: Nikita Pupko
" http://github.com/npupko/dotfiles
" General Config {{{

syntax on
" syntax sync fromstart
set nofoldenable
set visualbell
set relativenumber
set inccommand=nosplit
set nocursorline
set nocursorcolumn
set number
set confirm
set nohidden
set encoding=UTF-8
set clipboard+=unnamedplus
set list listchars=tab:\ \ ,trail:·,eol:¬
set nowrap

" Fuzzy matching
set path+=**                                                                " fuzzy matching with :find *.ext*
set wildmenu                                                                " Show list instead of just completing
set wildignore+=**/node_modules/**                                          " Ignore some folders
set wildignore+=**/.git/**
set wildignore+=**/build/**
set wildignore+=**/dist/**

set noswapfile
set nobackup
" }}}

" Indentation {{{
set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

let g:ruby_host_prog = 'rvm 2.7.2@global do neovim-ruby-host'
let g:node_host_prog = system('volta which neovim-node-host | tr -d "\n"')

let mapleader = ","
" lang en_US.UTF-8

lua vim.api.nvim_command([[command! Frt :normal gg O# frozen_string_literal: true<CR><ESC>x ]])

map <leader>cle :call CopyLinterError()<CR>

map <leader>cfp :let @+ = expand("%")<CR>

function! CopyLinterError()
  redir @+
  1message
  redir END
endfunction

map <leader>q :call BufClose()<CR>

function! BufClose()
  let bufcount = len(getbufinfo({'buflisted':1}))
  let text = bufcount ==# 1 ? execute('enew') : execute('bp')
  silent execute 'bw #'
endfunction

map <leader>d :call DeleteHiddenBuffers()<CR>

function! DeleteHiddenBuffers()
  let tpbl=[]
  call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
  for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
    silent execute 'bwipeout' buf
  endfor
endfunction

let g:fzf_action = {
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit' }
nnoremap <c-P> :Files<CR>
nnoremap <c-\> :Buffers<CR>
nnoremap <c-M> :History<CR>
" nunmap <CR>

if has('persistent_undo')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
endif

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set t_Co=256

set termguicolors
set background=dark
colorscheme gruvbox

nnoremap <leader>v :e $MYVIMRC<CR>
nnoremap <leader><c-v> :e /Users/random/.config/nvim/lua/plugins.lua<CR>
nnoremap <leader>V :source $MYVIMRC<CR>
nnoremap <leader>un :syntax sync fromstart<CR>:redraw!<CR>
nnoremap <leader>fef :normal! gg=G``<CR>

nnoremap <C-k> <C-w><Up>
nnoremap <C-j> <C-w><Down>
nnoremap <C-l> <C-w><Right>
nnoremap <C-h> <C-w><Left>

nnoremap _cs :setlocal filetype=css<CR>
nnoremap _co :setlocal filetype=coffee<CR>
nnoremap _ht :setlocal filetype=html<CR>
nnoremap _sl :setlocal filetype=slim<CR>
nnoremap _js :setlocal filetype=javascript<CR>
nnoremap _md :setlocal filetype=markdown<CR>
nnoremap _rb :setlocal filetype=ruby<CR>
nnoremap _sh :setlocal filetype=sh<CR>
nnoremap _vi :setlocal filetype=vim<CR>
nnoremap _an :setlocal filetype=yaml.ansible<CR>
nnoremap _dc :setlocal filetype=dockerfile<CR>

map <leader>cs :call CreateSpec()<CR>

function! CreateSpec()
  " This function requires tpope/rails.vim
  let l:file_path = expand('%')
  let l:spec_path = substitute(l:file_path, '\vapp\/(.+)\.rb', '\1', '')
  echo 'Espec ' . l:spec_path . '!'
  execute 'Espec ' . l:spec_path . '!'
endfunction

let g:elite_mode = 1
if get(g:, 'elite_mode')
  nnoremap <Up>    :resize +2<CR>
  nnoremap <Down>  :resize -2<CR>
  nnoremap <Left>  :vertical resize +2<CR>
  nnoremap <Right> :vertical resize -2<CR>
endif

if has('nvim')
  tmap <C-o> <C-\><C-n>
end

nnoremap Q @q
vnoremap Q :norm @q<cr>

vnoremap // y/<C-R>"<CR>
nnoremap <silent> // :nohlsearch<CR>
inoremap <C-c> <Esc><Esc>

map <leader>/ :call AddPry()<CR>

function! AddPry()
  if &filetype == 'ruby'
    execute "normal obinding.pry\<Esc>"
  elseif &filetype == 'svelte' || &filetype == 'js' || &filetype == 'ts'
    execute "normal odebugger\<Esc>"
  end
endfunction

lua require('plugins')

" vim:foldmethod=marker:
