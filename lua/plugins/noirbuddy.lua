return {
  "jesseleite/nvim-noirbuddy",
  enabled = false,
  dependencies = {
    "tjdevries/colorbuddy.nvim",
    branch = "dev"
  },
  config = function()
    vim.cmd([[colorscheme noirbuddy]])
    require('noirbuddy').setup {
      preset = 'slate',
      -- colors = {
      --   primary = '#FF0000',
      -- },
    }
  end,
}
