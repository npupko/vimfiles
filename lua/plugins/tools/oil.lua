return {
  "stevearc/oil.nvim",
  lazy = false,
  keys = {
    { "-", function() require("oil").open() end, desc = "Open parent directory" },
  },
  opts = {
    keymaps = { q = "actions.close" },
    default_file_explorer = true,
    split = "botright",
  },
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
}
