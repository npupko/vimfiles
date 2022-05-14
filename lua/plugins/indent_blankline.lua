-- vim.g.indent_blankline_filetype_exclude = {'NvimTree', 'help'}
-- vim.g.indent_blankline_use_treesitter = true

-- vim.g.indent_blankline_char_blankline = '┆'
-- vim.g.indent_blankline_char_list_blankline = { '|', '¦', '┆', '┊' }

require("indent_blankline").setup({
  -- show_current_context = true,
  -- show_current_context_start = false,
  filetype_exclude = {'NvimTree', 'help', 'packer'},
  use_treesitter = true,
})
