local opt = vim.opt
local fn = vim.fn
local api = vim.api
local M = {}

opt.foldenable = false
opt.visualbell = true
opt.relativenumber = true
opt.inccommand = 'nosplit'
opt.cursorline = false
opt.cursorcolumn = false
opt.number = true
opt.confirm = true
opt.hidden = false
opt.clipboard:append({"unnamedplus"})
opt.list = true
opt.listchars = { tab = '  ', trail = '·', eol = '¬' }
opt.wrap = false
opt.path:remove "/usr/include"
opt.path:append "**"
opt.undofile = true
opt.signcolumn = 'yes'

opt.foldlevel = 20
opt.foldmethod = 'expr'
opt.foldexpr = 'nvim_treesitter#foldexpr()'

-- Fuzzy matching
opt.wildmenu = true
opt.wildignore:append({"**/node_modules/**", "**/.git/**", "**/build/**", "**/dist/**"})

-- Backups
opt.swapfile = false
opt.backup = false

-- Indentation
opt.autoindent = true
opt.smartindent = true
opt.smarttab = true
opt.shiftwidth = 2
opt.softtabstop = 2
opt.tabstop = 2
opt.expandtab = true

-- Nodejs host
if fn.executable('volta') == 1 then
  vim.g.neovim_node_host = fn.trim(fn.system('volta which neovim-node-host'))
end

vim.g.mapleader = ','
vim.g.maplocalleader = ' '

vim.api.nvim_create_user_command('Frt', ':normal gg O# frozen_string_literal: true<CR><ESC>x', {})

function M.copyCurrentFilenameToClipboard()
  local filename = fn.expand('%:p')
  vim.fn.setreg('+', filename)
  print('Filename copied to clipboard: ' .. filename)
end

vim.keymap.set('n', '<leader>cfp', M.copyCurrentFilenameToClipboard)

function M.CloseCurrentBuffer()
  local buffers = fn.getbufinfo({buflisted = 1})
  if #buffers == 1 then
    api.nvim_command('enew')
  else
    api.nvim_command('bp')
  end
  api.nvim_buf_delete(fn.bufnr('#'), {})
end

function M.DeleteHiddenBuffers()
  local buffers = fn.getbufinfo({buflisted = 1})
  local currentBufferNumber = fn.bufnr('%')
  for _, buffer in ipairs(buffers) do
    if buffer.hidden and buffer.bufnr ~= currentBufferNumber then
      api.nvim_buf_delete(buffer.bufnr, {})
    end
  end
  print('Hidden buffers deleted')
end

vim.keymap.set('n', '<leader>q', M.CloseCurrentBuffer, { silent = true })
vim.keymap.set('n', '<leader>d', M.DeleteHiddenBuffers, { silent = true })

vim.cmd("let $NVIM_TUI_ENABLE_TRUE_COLOR=1")

-- opt.termguicolors = true
opt.background = 'dark'
vim.cmd('colorscheme gruvbox')

vim.keymap.set('n', '<leader>v', ':e $MYVIMRC<CR>')
vim.keymap.set('n', '<leader><c-v>', ':e /Users/random/.config/nvim/lua/plugins.lua<CR>')
vim.keymap.set('n', '<leader>V', ':source $MYVIMRC<CR>')
vim.keymap.set('n', '<leader>un', ':syntax sync fromstart<CR>:redraw!<CR>')
vim.keymap.set('n', '<leader>fef', ':normal! gg=G``<CR>')

vim.keymap.set('n', '<C-k>', '<C-w><Up>', { silent = true })
vim.keymap.set('n', '<C-j>', '<C-w><Down>', { silent = true })
vim.keymap.set('n', '<C-l>', '<C-w><Right>', { silent = true })
vim.keymap.set('n', '<C-h>', '<C-w><Left>', { silent = true })

local filetypesMapping = {
  css = '_cs',
  coffee = '_co',
  html = '_ht',
  slim = '_sl',
  javascript = '_js',
  markdown = '_md',
  ruby = '_rb',
  sh = '_sh',
  vim = '_vi',
  yaml = '_an',
  dockerfile = '_dc',
}

for lang, mapping in pairs(filetypesMapping) do
  local command = function() vim.api.nvim_command(string.format('setlocal filetype=%s', lang)) end
  vim.keymap.set('n', mapping, command, { silent = true })
end

vim.keymap.set('n', '<Up>', ':resize +2<CR>', { silent = true })
vim.keymap.set('n', '<Down>', ':resize -2<CR>', { silent = true })
vim.keymap.set('n', '<Left>', ':vertical resize +2<CR>', { silent = true })
vim.keymap.set('n', '<Right>', ':vertical resize -2<CR>', { silent = true })

vim.keymap.set('t', '<C-o>', [[<C-\><C-n>]], { silent = false, noremap = false })

vim.keymap.set('n', 'Q', '@q', { silent = true })
vim.keymap.set('v', 'Q', ':norm @q<CR>', { silent = true })

vim.keymap.set('v', '//', 'y/<C-R>"<CR>', { silent = true })
vim.keymap.set('n', '//', ':nohlsearch<CR>', { silent = true })
-- vim.keymap.set('i', '<C-c>', '<Esc><Esc>', { silent = true })
vim.keymap.set('i', '<C-c>', '<NOP>', { silent = true })

-- Expand filename for commands like Espec
vim.keymap.set('c', '<c-e>', [[<C-R>=substitute(expand('%:r'), '^app[^/]*.', '', '')<CR>]])

-- Open quickfix error in quickfix window
vim.keymap.set('n', '<localleader>q', [[:cg .git/quickfix.out<CR> :cwindow<CR>]])

function M.contains(list, x)
	for _, v in pairs(list) do
		if v == x then return true end
	end
	return false
end

function M.addDebuggerToNextLine()
  local filetype = vim.bo.filetype
  if filetype == 'lua' then
    vim.api.nvim_command('normal obinding.pry')
  elseif M.contains({'svelte', 'js', 'ts'}, filetype) then
    vim.api.nvim_command('normal odebugger')
  else
    vim.api.nvim_command('normal obinding.pry')
  end
end

vim.keymap.set('n', '<leader>/', M.addDebuggerToNextLine, { silent = true })

function M.copyLinterError()
  local current_line = vim.api.nvim_win_get_cursor(0)[1] - 1
  local result = vim.diagnostic.get(fn.bufnr('%'), { lnum = current_line })
  vim.fn.setreg('+', result[1].code)
end

vim.keymap.set('n', '<leader>cle', M.copyLinterError, { silent = true })

vim.g.loaded_sql_completion = 0
vim.g.omni_sql_no_default_maps = 1

require('plugins')
require('plugins.lsp')
