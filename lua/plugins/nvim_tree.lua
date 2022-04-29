vim.api.nvim_set_keymap('n', '<leader><leader>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>m', ':NvimTreeFindFile<CR>', { noremap = true, silent = true })

vim.g.nvim_tree_show_icons = {
  folders = 1,
  files = 1,
  git = 1,
  folder_arrows = 1,
}

require("nvim-tree").setup({
  renderer = {
    indent_markers = {
      enable = false,
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
