return {
  "nvim-neo-tree/neo-tree.nvim",
  enabled = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "kyazdani42/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  keys = {
    { "<leader><leader>", "<cmd>Neotree<CR>", desc = "Toggle NeoTree" },
    { "<leader>m", "<cmd>Neotree filesystem reveal<CR>", desc = "Find file in NeoTree" },
  },
  config = function()
    vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
  end,
}
