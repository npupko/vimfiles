return {
  'github/copilot.vim',
  enabled = true,
  config = function()
    vim.g.copilot_no_tab_map = true
    vim.g.copilot_assume_mapped = true
    -- Digitalocean VPS
    vim.g.copilot_proxy = "http://random:4405@209.38.196.167:3128"
    vim.keymap.set('i', '<M-\\>', '<Plug>(copilot-dismiss)', { silent = true })

    vim.g.copilot_filetypes = {
      markdown = true
    }
  end
}
