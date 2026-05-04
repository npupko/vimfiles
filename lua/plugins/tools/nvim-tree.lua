return {
  "nvim-tree/nvim-tree.lua",
  lazy = false,
  init = function()
    vim.keymap.set("n", "<leader><leader>", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle tree" })
    vim.keymap.set("n", "<leader>m", "<cmd>NvimTreeFindFile<CR>", { desc = "Reveal file" })
  end,
  dependencies = {
    "echasnovski/mini.icons",
  },
  opts = {
    git = {
      timeout = 5000,
    },
    filters = {
      git_ignored = true,
    },
    renderer = {
      indent_markers = { enable = false },
      icons = {
        webdev_colors = true,
        git_placement = "after",
        show = {
          folder = true,
          file = true,
          git = true,
          folder_arrow = true,
        },
      },
    },
    update_focused_file = { enable = false },
    view = { width = 50 },
  },
}
