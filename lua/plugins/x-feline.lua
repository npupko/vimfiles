return {
  'feline-nvim/feline.nvim',
  enabled = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  init = function ()
    local feline = require('feline')

    local gruvbox = {
      fg = '#928374',
      bg = '#1F2223',
      black ='#1B1B1B',
      skyblue = '#458588',
      cyan = '#83a597',
      green = '#689d6a',
      oceanblue = '#1d2021',
      magenta = '#fb4934',
      orange = '#fabd2f',
      red = '#cc241d',
      violet = '#b16286',
      white = '#ebdbb2',
      yellow = '#d79921',
    }

    feline.setup({
      theme = gruvbox,
    })
    feline.winbar.setup()

    vim.o.laststatus = 3
  end
}
