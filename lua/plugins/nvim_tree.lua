vim.api.nvim_set_keymap('n', '<leader><leader>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>m', ':NvimTreeFindFile<CR>', { noremap = true, silent = true })

require("nvim-tree").setup({
  renderer = {
    indent_markers = {
      enable = false,
    },
    icons = {
      webdev_colors = true,
      git_placement = "after",
      show = {
        folder = true,
        file = true,
        git = true,
        folder_arrow = true,
      }
    }
  },
  update_focused_file = {
    enable = false,
  },
  view = {
    width = 50,
    hide_root_folder = false,
  },
})
