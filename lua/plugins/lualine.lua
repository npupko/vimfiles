return {
  'nvim-lualine/lualine.nvim',
  enabled = true,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  opts = {
    options = {
      icons_enabled = true,
      theme = 'gruvbox',
      -- theme = 'kanagawa',
      component_separators = { left = '', right = ''},
      section_separators = { left = '', right = ''},
      disabled_filetypes = {},
      always_divide_middle = true,
      globalstatus = false,
    },
    sections = {
      lualine_a = {'mode'},
      -- lualine_b = {'branch', 'diff', 'diagnostics', 'searchcount'},
      lualine_b = {'diff', 'diagnostics', 'searchcount'},
      lualine_c = {
        {
          'filename',
          path = 1
        }
      },
      lualine_x = {'encoding', 'fileformat', 'filetype'},
      lualine_y = {'progress'},
      lualine_z = {'location'}
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {'filename'},
      lualine_x = {'location'},
      lualine_y = {},
      lualine_z = {}
    },
    -- tabline = {
    --   -- lualine_a = {'buffers'},
    --   lualine_a = {},
    --   -- lualine_a = {'tabs'},
    --   lualine_b = {},
    --   lualine_c = {'filename'},
    --   lualine_x = {},
    --   lualine_y = {},
    --   lualine_z = {'tabs'}
    -- },
    -- winbar = {
    --   lualine_a = {},
    --   lualine_c = {'filename'},
    --   lualine_x = {},
    --   lualine_y = {},
    --   lualine_z = {}
    -- },
    -- inactive_winbar = {
    --   lualine_a = {},
    --   lualine_b = {},
    --   lualine_c = {'filename'},
    --   lualine_x = {},
    --   lualine_y = {},
    --   lualine_z = {}
    -- },
    -- extensions = {'fugitive', 'neo-tree', 'quickfix'}
    extensions = {'fugitive', 'nvim-tree', 'quickfix'}
  }
}
