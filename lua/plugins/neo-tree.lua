return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = "v2.x",
  enabled = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
    {
      's1n7ax/nvim-window-picker',
      tag = "v1.5",
      opts = {
        autoselect_one = true,
        include_current = false,
        filter_rules = {
          -- filter using buffer options
          bo = {
            -- if the file type is one of following, the window will be ignored
            filetype = { 'neo-tree', "neo-tree-popup", "notify" },

            -- if the buffer type is one of following, the window will be ignored
            buftype = { 'terminal', "quickfix" },
          },
        },
        -- other_win_hl_color = '#e35e4f',
      }
    }
  },
  init = function()
    vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
  end,
  keys = {
    { "<leader><leader>", "<cmd>Neotree toggle<CR>", desc = "Toggle NeoTree" },
    { "<leader>m", "<cmd>Neotree filesystem reveal<CR>", desc = "Find file in NeoTree" },
  },
  opts = {
    enable_diagnostics = false,
    window = {
      -- width = 30,
      mappings = {
        ["<space>"] = false, -- disable space until we figure out which-key disabling
        o = "open",
        -- H = "prev_source",
        -- L = "next_source",
      },
    },
    default_component_configs = {
      -- icon = {
      --   -- folder_closed = "",
      --   -- folder_open = "",
      --   -- folder_empty = "",
      -- },
      -- modified = {
      --   symbol = "",
      --   highlight = "NeoTreeModified",
      -- },
      -- git_status = {
      --   symbols = {
      --     untracked = "",
      --     ignored   = "",
      --     unstaged  = "",
      --     staged    = "",
      --     conflict  = "",
      --   }
      -- },
    },
    event_handlers = {
      {
        event = "vim_buffer_enter",
        handler = function()
          if vim.bo.filetype == "neo-tree" then
            vim.cmd [[setlocal scl=auto]]
          end
        end
      }
    },
    filesystem = {
      follow_current_file = true,
      hijack_netrw_behavior = "open_current",
      use_libuv_file_watcher = true,
      -- window = {
      --   mappings = {
      --     h = "toggle_hidden",
      --   },
      -- },
    },
  },
  -- config = function()
  --   local icons = require'nvim-web-devicons'
  --
  --   vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
  --   require("neo-tree").setup({
  --     close_if_last_window = true,
  --     enable_diagnostics = false,
  --     source_selector = {
  --       winbar = true,
  --       content_layout = "center",
  --     },
  --     default_component_configs = {
  --       name = {
  --         use_git_status_colors = false
  --       },
  --     },
  --     window = {
  --       -- width = 30,
  --       mappings = {
  --         ["<space>"] = false, -- disable space until we figure out which-key disabling
  --         o = "open",
  --         H = "prev_source",
  --         L = "next_source",
  --       },
  --     },
  --     git_status = {
  --       symbols = {
  --         -- Change type
  --         added     = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
  --         modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
  --         deleted   = "✖",-- this can only be used in the git_status source
  --         renamed   = "",-- this can only be used in the git_status source
  --         -- Status type
  --         untracked = "",
  --         ignored   = "",
  --         unstaged  = "",
  --         staged    = "",
  --         conflict  = "",
  --       }
  --     },
  --     filesystem = {
  --       follow_current_file = true,
  --       hijack_netrw_behavior = "open_current",
  --       use_libuv_file_watcher = true,
  --       window = {
  --         mappings = {
  --           h = "toggle_hidden",
  --         },
  --       },
  --     },
  --     event_handlers = {
  --       { event = "neo_tree_buffer_enter", handler = function(_) vim.opt_local.signcolumn = "auto" end },
  --     },
  --   })
  -- end,
}
