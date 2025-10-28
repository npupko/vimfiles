return {
  'echasnovski/mini.nvim',
  version = false,
  enabled = false,
  priority = 500,
  -- keys = {
  --   { '-', require('mini.files').open, desc = 'Open parent directory with mini.files' },
  -- },
  config = function ()
    -- require('mini.splitjoin').setup({
    --   mappings = {
    --     toggle = 'gT',
    --     split = 'gS',
    --     join = 'gJ',
    --   }
    -- })
    local minifiles = require('mini.files')
    minifiles.setup({ })
    vim.keymap.set('n', '-', minifiles.open)
  end
}
