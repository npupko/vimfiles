return {
  "tpope/vim-dadbod",
  enabled = false,
  cmd = { "DB", "DBUI", "DBUIToggle" },
  init = function()
    vim.g.db = "postgresql://postgres:password@localhost/yipit_development"
  end,
}
