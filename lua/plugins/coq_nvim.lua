return {
  "ms-jpq/coq_nvim",
  enabled = false,
  config = function()
    -- vim.cmd [[COQnow]]
    vim.g.coq_settings = {
      auto_start = 'shut-up',
      keymap = {
        recommended = true,
        jump_to_mark = "<S-Tab>"
      },
      clients = {
        tabnine = {
          enabled = true,
        }
      },
    }
  end,
}
