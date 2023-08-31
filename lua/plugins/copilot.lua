return {
  'github/copilot.vim',
  enabled = true,
  config = function()
    vim.g.copilot_no_tab_map = true
    vim.g.copilot_assume_mapped = true
    -- Digitalocean VPS
    vim.g.copilot_proxy = os.getenv("COPILOT_PROXY_URL")
    vim.keymap.set('i', '<M-\\>', '<Plug>(copilot-dismiss)', { silent = true })

    vim.g.copilot_filetypes = {
      markdown = true
    }
  end
}
