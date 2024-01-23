return {
  event = "VeryLazy",
  "npupko/buddy.nvim",
  config = function ()
    local buddy = require('buddy')
    buddy.setup({})

    vim.keymap.set('n', '<leader>/', buddy.add_debugger, { silent = true, desc = 'Add debugger to next line' })
    vim.keymap.set('n', '<leader>cle', buddy.copy_linter_error, { silent = true, desc = 'Copy linter error' })
    vim.keymap.set('n', '<leader>clb', buddy.open_linter_error_in_browser, { silent = true, desc = 'Open linter error in browser' })

    vim.api.nvim_create_user_command('Frt', buddy.prepend_file_with_magic_comment, { desc = 'Add magic comment line to file' })
  end,
  dev = true
}
