return {
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  enabled = false,
  opts = {
    exclude = {
      filetypes = {
        'packer',
        'NvimTree',
      },
    },
    scope = {
      show_start = false,
      show_end = false
    }
  },
  priority = 70,
}
