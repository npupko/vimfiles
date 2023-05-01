return {
  'github/copilot.vim',
  enabled = true,
  config = function()
    vim.g.copilot_no_tab_map = true
    vim.g.copilot_assume_mapped = true
    vim.keymap.set('i', '<M-\\>', '<Plug>(copilot-dismiss)', { silent = true })

    vim.g.copilot_filetypes = {
      markdown = true
    }
  end
}
