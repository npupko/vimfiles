return {
  "folke/snacks.nvim",
  enabled = true,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    picker = { enabled = true },
    indent = {
      enabled = true,
      animate = {
        enabled = false,
      },
    }
  }
}
