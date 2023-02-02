vim.api.nvim_set_keymap('n', '<leader><leader>', ':CHADopen<CR>', { noremap = true, silent = true })

vim.g.chadtree_settings = {
  theme = {
    -- text_colour_set = 'nord'
    text_colour_set = 'env'
  },
  keymap = {
    open_sys = {},
  },
  keymap = {
    secondary = { "o" }
  }
}
