return {
  "TabbyML/vim-tabby",
  event = "InsertEnter",
  dependencies = {
    "neovim/nvim-lspconfig",
  },
  init = function()
    vim.g.tabby_agent_start_command = { "bunx", "tabby-agent", "--stdio" }
    vim.g.tabby_inline_completion_trigger = "auto"
  end,
}
