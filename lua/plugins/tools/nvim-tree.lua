return {
  "nvim-tree/nvim-tree.lua",
  cmd = {
    "NvimTreeToggle",
    "NvimTreeFocus",
    "NvimTreeFindFile",
    "NvimTreeCollapse",
  },
  keys = {
    { "<leader><leader>", "<cmd>NvimTreeToggle<CR>", desc = "Toggle tree" },
    { "<leader>m", "<cmd>NvimTreeFindFile<CR>", desc = "Reveal file" },
  },
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
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
