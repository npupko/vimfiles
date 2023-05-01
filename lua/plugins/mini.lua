return {
  'echasnovski/mini.nvim',
  version = false,
  enabled = false,
  config = function ()
    require('mini.splitjoin').setup({
      mappings = {
        toggle = 'gT',
        split = 'gS',
        join = 'gJ',
      }
    })
  end
}
