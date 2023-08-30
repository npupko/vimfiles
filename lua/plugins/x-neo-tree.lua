return {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = false,
    branch = "v3.x",
    keys = {
      { "<leader><leader>", "<cmd>Neotree toggle<CR>", desc = "Toggle NeoTree" },
      { "<leader>m", "<cmd>Neotree filesystem reveal<CR>", desc = "Find file in NeoTree" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    }
}
