return {
  'lukas-reineke/indent-blankline.nvim',
  enabled = true,
  opts = {
    filetype_exclude = {'NvimTree', 'help', 'packer'},
    use_treesitter = true,
    show_current_context = true,
  },
  priority = 70,
}
