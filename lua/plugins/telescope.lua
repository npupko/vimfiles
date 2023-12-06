return {
  'nvim-telescope/telescope.nvim',
  -- commit = '80eefd8ff00145ef6ca4b7c64ef355b224f6e630',
  enabled = true,
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
  },
  config = function()
    local T = require('telescope.builtin')
    local M = {}

    vim.keymap.set('n', '<c-P>', T.find_files, {desc = 'Open file picker'})
    vim.keymap.set('n', '<c-\\>', function () T.buffers { sort_mru = true } end, {desc = 'Open buffer picker'})
    vim.keymap.set('n', '<localleader>o', T.oldfiles, {desc = 'Open old files picker'})
    vim.keymap.set('n', '<leader>p', T.live_grep, {desc = 'Open grep picker'})
    vim.keymap.set('n', '<localleader>m', T.keymaps, {desc = 'Open keymaps picker'})
    vim.keymap.set('n', '<localleader>g', function() T.grep_string({search = vim.fn.expand("<cword>")}) end, {desc = 'Grep for word under cursor'})

    function M.grepWithPrompt() vim.ui.input({prompt = 'Grep > '}, function(value) require('telescope.builtin').grep_string({search = value}) end) end

    vim.keymap.set('n', '<localleader>G', M.grepWithPrompt, {desc = 'Grep with prompt'})

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
