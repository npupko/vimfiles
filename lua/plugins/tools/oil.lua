return {
  "stevearc/oil.nvim",
  cmd = { "Oil" },
  keys = {
    { "-", function() require("oil").open() end, desc = "Open parent directory" },
  },
  opts = {
    keymaps = { q = "actions.close" },
    default_file_explorer = false,
    split = "botright",
  },
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
}
