local T = require('telescope.builtin')
local M = {}

-- vim.keymap.set('n', '<c-\\>', function () T.buffers { sort_lastused = true, ignore_current_buffer = true } end)
vim.keymap.set('n', '<c-P>', T.find_files)
vim.keymap.set('n', '<c-\\>', function () T.buffers { sort_mru = true } end)
vim.keymap.set('n', '<c-CR>', T.oldfiles)
vim.keymap.set('n', '<leader>p', T.live_grep)
vim.keymap.set('n', '<localleader>m', T.keymaps)
vim.keymap.set('n', '<localleader>g', function() T.grep_string({search = vim.fn.expand("<cword>")}) end)

function M.grepWithPrompt() vim.ui.input({prompt = 'Grep > '}, function(value) require('telescope.builtin').grep_string({search = value}) end) end

vim.keymap.set('n', '<localleader>G', M.grepWithPrompt)
-- vim.api.nvim_set_keymap('n', '<c-P>', "<cmd>lua require('telescope.builtin').find_files()<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<c-\\>', "<cmd>lua require('telescope.builtin').buffers()<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<c-M>', "<cmd>lua require('telescope.builtin').oldfiles()<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>p', "<cmd>lua require('telescope.builtin').live_grep()<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<localleader>m', "<cmd>lua require('telescope.builtin').keymaps()<CR>", { noremap = true, silent = true })

local actions = require("telescope.actions")

require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
    },
    pickers = {
      find_files = {
        find_command = { "fd", "--type", "f", "--strip-cwd-prefix" }
      },
    },
  }
}

require('telescope').load_extension('fzf')
