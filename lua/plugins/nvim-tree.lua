-- vim.api.nvim_set_keymap('n', '<leader><leader>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>m', ':NvimTreeFindFile<CR>', { noremap = true, silent = true })

return {
  'kyazdani42/nvim-tree.lua',
  enabled = true,
  keys = {
    { '<leader><leader>', '<cmd>NvimTreeToggle<CR>', desc = 'Toggle NvimTree' },
    { '<leader>m', '<cmd>NvimTreeFindFile<CR>', desc = 'Find file in NvimTree' }
  },
  dependencies = {
    'nvim-tree/nvim-web-devicons', -- optional, for file icon
  },
  opts = {
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
    },
  }
}

