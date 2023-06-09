return {
  'Wansmer/treesj',
  enabled = true,
  -- keys = { '<leader>m', '<leader>j', '<leader>s' },
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function()
    local treesj = require('treesj')
    local lang_utils = require('treesj.langs.utils')

    local langs = {
      ruby = {
        body_statement = lang_utils.set_preset_for_non_bracket({
          both = {
            enable = function(tsn)
              local t = tsn:parent():type()
              return not (t == 'block' or t == 'do_block')
            end,
          },
        }),
      }
    }

    treesj.setup({
      use_default_keymaps = false,
      max_join_length = 1000,
      langs = langs,
    })

    vim.keymap.set('n', 'gm', require('treesj').toggle, { desc = 'Toggle split/join' })
    vim.keymap.set('n', 'gS', require('treesj').split, { desc = 'Split line' })
    vim.keymap.set('n', 'gJ', require('treesj').join, { desc = 'Join lines' })
  end,
}
