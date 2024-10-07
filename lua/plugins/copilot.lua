return {
  event = "VeryLazy",
  'github/copilot.vim',
  -- tag = "v1.18.0",
  enabled = true,
  config = function()
    vim.g.copilot_no_tab_map = true
    vim.g.copilot_assume_mapped = true
    -- Digitalocean VPS
    vim.g.copilot_proxy = os.getenv("COPILOT_PROXY_URL")
    vim.keymap.set('i', '<M-\\>', '<Plug>(copilot-dismiss)', { silent = true })

    vim.g.workspace_folders = {
      "~/Projects/Yipit/spendhound",
      "~/Projects/Yipit/spendhound_infrastructure",

    }

    vim.g.copilot_filetypes = {
      markdown = true
    }
  end
}
