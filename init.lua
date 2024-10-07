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
opt.laststatus = 2

-- Need to make Oil work properly
opt.splitright = true
-- opt.splitbelow = true

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
opt.smartindent = false
opt.smarttab = true
opt.shiftwidth = 2
opt.softtabstop = 2
opt.tabstop = 2
opt.expandtab = true

vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0

-- vim.cmd([[
-- set langmap='ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ, фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz'
-- ]])
vim.g.langmap = 'ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ, фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz'
-- opt.keymap='russian-jcukenwin'


-- Nodejs host
-- if fn.executable('volta') == 1 then
--   vim.g.neovim_node_host = fn.trim(fn.system('volta which neovim-node-host'))
-- end

vim.g.host_ruby_prog = fn.trim(fn.system('which ruby'))

vim.g.mapleader = ','
vim.g.maplocalleader = ' '

-- function M.prependFileWithMagicComment()
--   local line = '# frozen_string_literal: true'
--   local currentLine = fn.getline(1)
--   if currentLine ~= line then
--     api.nvim_command("1s/^/" .. line .. "\r\r")
--     api.nvim_command("noh")
--   end
--
-- end
--
-- vim.api.nvim_create_user_command('Frt', M.prependFileWithMagicComment, { desc = 'Add magic comment line to file' })

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
vim.keymap.set('n', '<leader>rs', ':syntax sync fromstart<CR>:redraw!<CR>', { desc = 'Reload syntax' })
vim.keymap.set('n', '<leader>fef', ':normal! gg=G``<CR>', { desc = 'Format file' })
vim.keymap.set('n', '<leader>g', function() vim.cmd("G") end, { desc = 'Git status' })

vim.keymap.set('n', '<C-k>', '<C-w><Up>', { silent = true, desc = 'Move to window above' })
vim.keymap.set('n', '<C-j>', '<C-w><Down>', { silent = true, desc = 'Move to window below' })
vim.keymap.set('n', '<C-l>', '<C-w><Right>', { silent = true, desc = 'Move to window right' })
vim.keymap.set('n', '<C-h>', '<C-w><Left>', { silent = true, desc = 'Move to window left' })

-- disable Shift+K in visual mode
vim.keymap.set('v', 'K', '<Nop>', { silent = true })

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

vim.keymap.set('v', '<localleader>/', 'y/<C-R>"<CR>', { silent = true, desc = 'Search for selected text' })
vim.keymap.set('n', '<localleader>/', ':nohlsearch<CR>', { silent = true, desc = 'Clear search' })
-- vim.keymap.set('i', '<C-c>', '<Esc><Esc>', { silent = true })
vim.keymap.set('i', '<C-c>', '<NOP>', { silent = true, desc = 'Do nothing' })

-- Expand filename for commands like Espec
vim.keymap.set('c', '<c-e>', [[<C-R>=substitute(expand('%:r'), '^app[^/]*.', '', '')<CR>]], { desc = 'Expand filename' })

-- Open quickfix error in quickfix window
vim.keymap.set('n', '<localleader>q', [[:cg .git/quickfix.out<CR> :cwindow<CR>]], { desc = 'Open quickfix error in quickfix window' })

-- -- replaced with buddy.nvim plugin
-- function M.contains(list, x)
-- 	for _, v in pairs(list) do
-- 		if v == x then return true end
-- 	end
-- 	return false
-- end
-- function M.addDebuggerToNextLine()
--   local filetype = vim.bo.filetype
--   if filetype == 'lua' then
--     vim.api.nvim_command('normal obinding.pry')
--   elseif M.contains({'svelte', 'js', 'ts'}, filetype) then
--     vim.api.nvim_command('normal odebugger')
--   else
--     vim.api.nvim_command('normal obinding.pry')
--   end
-- end
--
-- vim.keymap.set('n', '<leader>/', M.addDebuggerToNextLine, { silent = true, desc = 'Add debugger to next line' })

function M.copyStrAndOpen()
  -- local text = vim.fn.expand('<cword>')
  -- vim.fn.setreg('+', text)
  vim.api.nvim_command('normal! yi\'')
  local text = vim.fn.getreg('+')
  vim.fn.system('open https://github.com/' .. text)
end

vim.keymap.set('n', '<leader>op', M.copyStrAndOpen, { silent = true, desc = 'Copy word and open in browser' })

vim.keymap.set('n', '<leader>A', '<CMD>argadd %<CR>', { silent = false, desc = 'Add current file to arglist' })

-- function M.copyLinterError()
--   local current_line = vim.api.nvim_win_get_cursor(0)[1] - 1
--   local result = vim.diagnostic.get(fn.bufnr('%'), { lnum = current_line })
--   vim.fn.setreg('+', result[1].code)
-- end
--
-- vim.keymap.set('n', '<leader>cle', M.copyLinterError, { silent = true, desc = 'Copy linter error' })

-- inoremap <C-c> <Esc>
vim.keymap.set('i', '<C-c>', '<Esc>', { silent = true, desc = 'Exit insert mode' })

-- Function to insert issue ID into commit message
local function insert_issue_id()
  -- Get current buffer contents
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

  -- Find the line with the branch name
  local branch_name_line = ""
  for _, line in ipairs(lines) do
    if line:match("^# On branch ") then
      branch_name_line = line
      break
    end
  end

  -- Extract the issue ID from the branch name
  local issue_id = branch_name_line:match("%w+%-%d+")
  if not issue_id then
    print("Issue ID could not be found in the branch name.")
    return
  end

  -- Insert [ISSUE_ID] at the beginning of the first non-comment line
  for i, line in ipairs(lines) do
    if not line:match("^#") then
      local new_line = "[" .. issue_id .. "] " .. line
      vim.api.nvim_buf_set_lines(0, i - 1, i, false, {new_line})
      break
    end
  end
end

-- Mapping <leader>i to the insert_issue_id function in .git/COMMIT_EDITMSG buffers
vim.api.nvim_create_autocmd("FileType", {
  pattern = "gitcommit",
  callback = function()
    vim.keymap.set('n', '<leader>i', insert_issue_id, {buffer = true})
  end,
})

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

-- LSP formatting on <leader>ff
vim.keymap.set('n', '<leader>ff', function() vim.lsp.buf.format({async = true}) end, { silent = true, desc = 'Format with LSP' })

require("lazy").setup("plugins", {
  install = { colorscheme = { "gruvbox", "habamax" } },
  change_detection = {
    enabled = true,
    notify = false,
  },
  dev = {
    path = "~/Projects/npupko"
  },
  checker = { enabled = false },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "ruby",
    callback = function()
        vim.bo.includeexpr = "v:lua.rails_container_to_file(v:fname)"
    end,
})

function _G.rails_container_to_file(expr)
    -- Debug output
    vim.api.nvim_out_write("Original expression: " .. expr .. "\n")

    -- Remove Container prefix and any potential trailing characters including the brackets
    local container_path = expr:gsub('^Container%[["\']', ''):gsub('["\']%]$', '')

    -- Debug output
    vim.api.nvim_out_write("Container path: " .. container_path .. "\n")

    -- Replace dots with directory separators
    local file_path = container_path:gsub('%.', '/')

    -- Append the .rb file extension
    local result_path = 'app/services/' .. file_path .. '.rb'

    -- Debug output
    vim.api.nvim_out_write("Resulting file path: " .. result_path .. "\n")

    return result_path
end

-- You can also add this line to ensure your 'path' includes the Rails directories
vim.opt.path:append { "app/**", "lib/**", "config/**", "test/**", "spec/**" }
