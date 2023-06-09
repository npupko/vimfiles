return {
  'stevearc/oil.nvim',
  keys = {
    { '-', function() require('oil').open() end, desc = 'Open parent directory' },
  },
  config = true,
  cmd = { 'Oil' },
  dependencies = { "nvim-tree/nvim-web-devicons" },
}
