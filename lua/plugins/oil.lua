return {
  'stevearc/oil.nvim',
  enabled = true,
  commit = '636989b603fb95032efa9d3e1b3323c8bb533e91',
  keys = {
    { '-', function() require('oil').open() end, desc = 'Open parent directory' },
  },
  opts = {
    default_file_explorer = false,
    split = "botright",
    -- view_options = {
    --   show_hidden = true,
    -- },
    -- preview = {
    --   width = 0.5,
    -- },
  },
  cmd = { 'Oil' },
  dependencies = { "nvim-tree/nvim-web-devicons" },
}
