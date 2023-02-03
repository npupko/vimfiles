return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
  },
  config = function()
    local T = require('telescope.builtin')
    local M = {}

    vim.keymap.set('n', '<c-P>', T.find_files)
    vim.keymap.set('n', '<c-\\>', function () T.buffers { sort_mru = true } end)
    vim.keymap.set('n', '<c-Enter>', T.oldfiles)
    vim.keymap.set('n', '<leader>p', T.live_grep)
    vim.keymap.set('n', '<localleader>m', T.keymaps)
    vim.keymap.set('n', '<localleader>g', function() T.grep_string({search = vim.fn.expand("<cword>")}) end)

    function M.grepWithPrompt() vim.ui.input({prompt = 'Grep > '}, function(value) require('telescope.builtin').grep_string({search = value}) end) end

    vim.keymap.set('n', '<localleader>G', M.grepWithPrompt)

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
  end
}