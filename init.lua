local opt = vim.opt
local fn = vim.fn
local api = vim.api
local M = {}

-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

opt.foldenable = false
opt.visualbell = true
opt.relativenumber = true
opt.inccommand = 'nosplit'
opt.cursorline = false
opt.cursorcolumn = false
opt.number = true
opt.confirm = true
opt.hidden = true
opt.clipboard:append({"unnamedplus"})
opt.list = true
opt.listchars = { tab = '  ', trail = '·', eol = '¬' }
opt.wrap = false
opt.path:remove "/usr/include"
opt.path:append "**"
opt.undofile = true
opt.signcolumn = 'yes'
opt.showtabline = 1
-- disable mouse
opt.mouse = ''


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

vim.g.host_ruby_prog = fn.trim(fn.system('which ruby'))

vim.g.mapleader = ','
vim.g.maplocalleader = ' '

vim.api.nvim_create_user_command('Frt', ':normal gg O# frozen_string_literal: true<CR><ESC>x', {})

function M.copyCurrentFilenameFromProjectRootToClipboard()
  local filename = fn.expand('%:p')
  filename = fn.fnamemodify(filename, ':~:.')
  local projectRoot = fn.system('git rev-parse --show-toplevel')
  projectRoot = fn.fnamemodify(projectRoot, ':~:.')
  filename = fn.substitute(filename, projectRoot, '', '')
  vim.fn.setreg('+', filename)
  print('Filename copied to clipboard: ' .. filename)
end

vim.keymap.set('n', '<leader>cfp', M.copyCurrentFilenameFromProjectRootToClipboard)

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

vim.keymap.set('n', '<leader>q', M.CloseCurrentBuffer, { silent = true, desc = 'Close current buffer' })
vim.keymap.set('n', '<leader>d', M.DeleteHiddenBuffers, { silent = true, desc = 'Delete hidden buffers' })

vim.cmd("let $NVIM_TUI_ENABLE_TRUE_COLOR=1")

opt.termguicolors = true
opt.background = 'dark'

-- local has_termguicolors = vim.fn.exists('+termguicolors')
-- if has_termguicolors then
--   vim.o.t_8f = "\27[38;2;%lu;%lu;%lum"
--   vim.o.t_8b = "\27[48;2;%lu;%lu;%lum"
-- end
-- vim.cmd('colorscheme gruvbox')

vim.keymap.set('n', '<leader>v', ':e $MYVIMRC<CR>', { desc = 'Edit vimrc' })
vim.keymap.set('n', '<leader><c-v>', ':cd /Users/random/.config/nvim/lua/plugins<CR>', { desc = 'Edit plugins' })
vim.keymap.set('n', '<leader>V', ':source $MYVIMRC<CR>', { desc = 'Reload vimrc' })
vim.keymap.set('n', '<leader>un', ':syntax sync fromstart<CR>:redraw!<CR>', { desc = 'Reload syntax' })
vim.keymap.set('n', '<leader>fef', ':normal! gg=G``<CR>', { desc = 'Format file' })

vim.keymap.set('n', '<C-k>', '<C-w><Up>', { silent = true, desc = 'Move to window above' })
vim.keymap.set('n', '<C-j>', '<C-w><Down>', { silent = true, desc = 'Move to window below' })
vim.keymap.set('n', '<C-l>', '<C-w><Right>', { silent = true, desc = 'Move to window right' })
vim.keymap.set('n', '<C-h>', '<C-w><Left>', { silent = true, desc = 'Move to window left' })

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
  vim.keymap.set('n', mapping, command, { silent = true, desc = 'Set filetype to ' .. lang })
end

vim.keymap.set('n', '<Up>', ':resize +2<CR>', { silent = true, desc = 'Increase window height' })
vim.keymap.set('n', '<Down>', ':resize -2<CR>', { silent = true, desc = 'Decrease window height' })
vim.keymap.set('n', '<Left>', ':vertical resize +2<CR>', { silent = true, desc = 'Increase window width' })
vim.keymap.set('n', '<Right>', ':vertical resize -2<CR>', { silent = true, desc = 'Decrease window width' })

vim.keymap.set('t', '<C-o>', [[<C-\><C-n>]], { silent = false, noremap = false, desc = 'Exit terminal mode' })

vim.keymap.set('n', 'Q', '@q', { silent = true, desc = 'Execute macro' })
vim.keymap.set('v', 'Q', ':norm @q<CR>', { silent = true, desc = 'Execute macro' })

vim.keymap.set('v', '//', 'y/<C-R>"<CR>', { silent = true, desc = 'Search for selected text' })
vim.keymap.set('n', '//', ':nohlsearch<CR>', { silent = true, desc = 'Clear search' })
-- vim.keymap.set('i', '<C-c>', '<Esc><Esc>', { silent = true })
vim.keymap.set('i', '<C-c>', '<NOP>', { silent = true, desc = 'Do nothing' })

-- Expand filename for commands like Espec
vim.keymap.set('c', '<c-e>', [[<C-R>=substitute(expand('%:r'), '^app[^/]*.', '', '')<CR>]], { desc = 'Expand filename' })

-- Open quickfix error in quickfix window
vim.keymap.set('n', '<localleader>q', [[:cg .git/quickfix.out<CR> :cwindow<CR>]], { desc = 'Open quickfix error in quickfix window' })

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

vim.keymap.set('n', '<leader>/', M.addDebuggerToNextLine, { silent = true, desc = 'Add debugger to next line' })

function M.copyStrAndOpen()
  -- local text = vim.fn.expand('<cword>')
  -- vim.fn.setreg('+', text)
  vim.api.nvim_command('normal! yi\'')
  local text = vim.fn.getreg('+')
  vim.fn.system('open https://github.com/' .. text)
end

vim.keymap.set('n', '<leader>op', M.copyStrAndOpen, { silent = true, desc = 'Copy word and open in browser' })

vim.keymap.set('n', '<leader>a', '<CMD>argadd %<CR>', { silent = true, desc = 'Add current file to arglist' })

function M.copyLinterError()
  local current_line = vim.api.nvim_win_get_cursor(0)[1] - 1
  local result = vim.diagnostic.get(fn.bufnr('%'), { lnum = current_line })
  vim.fn.setreg('+', result[1].code)
end

vim.keymap.set('n', '<leader>cle', M.copyLinterError, { silent = true, desc = 'Copy linter error' })

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

M.is_empty = function(str) return str == nil or str == "" end

-- local get_filename = function(path)
--     local filename_with_relative_path = vim.fn.substitute(path, vim.fn.getcwd() .. "/", "", "")
--     local filename = filename_with_relative_path:match("([^/]+)$")
--
--     if M.is_empty(filename) then
--         return " %f"
--     end
--
--     return filename
-- end
--
-- local filename = get_filename(vim.fn.expand("%"))
-- vim.opt.winbar = " " .. filename .. " %m"
-- vim.opt_local.winbar = "%f"

require("lazy").setup("plugins")
