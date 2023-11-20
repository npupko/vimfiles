return {
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  enabled = true,
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
