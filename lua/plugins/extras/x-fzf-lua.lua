return {
  "ibhagwan/fzf-lua",
  enabled = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    { 'junegunn/fzf', build = function() vim.fn['fzf#install']() end },
  },
  -- keys = {
  --   { '<c-P>', require("fzf-lua").files, desc = 'Find files' },
  --   { '<c-\\>', require("fzf-lua").buffers, desc = 'Find buffers' },
  --   { '<c-Enter>', require("fzf-lua").history, desc = 'Find history' },
  --   { '<leader>p', require("fzf-lua").live_grep, desc = 'Find in project' },
  --   { '<localleader>m', require("fzf-lua").keymaps, desc = 'Find mappings' }
  -- },
  config = function()
    local actions = require "fzf-lua.actions"
    -- calling `setup` is optional for customization
    require("fzf-lua").setup({
      -- 'skim',
      fzf_opts = {
        ["--info"] = false,
        ["--layout"] = 'default',
      },
      winopts = {
        preview = {
          vertical = "down:45%",
          horizontal = "right:50%",
        }
      },
      actions = {
        buffers = {
          ["default"] = actions.buf_edit,
          ["ctrl-x"]  = actions.buf_split,
          ["ctrl-v"]  = actions.buf_vsplit,
          ["ctrl-t"]  = actions.buf_tabedit,
        },
      },
      buffers = {
        actions = { ["ctrl-x"] = false, ["ctrl-d"] = { actions.buf_del, actions.resume } },
      },
    })

    vim.keymap.set('n', '<c-P>', require('fzf-lua').files, { noremap = true, silent = true })
    vim.keymap.set('n', '<c-\\>', require("fzf-lua").buffers, { noremap = true, silent = true })
    vim.keymap.set('n', '<c-Enter>', require("fzf-lua").oldfiles, { noremap = true, silent = true })
    vim.keymap.set('n', '<leader>p', require("fzf-lua").live_grep, { noremap = true, silent = true })
    vim.keymap.set('n', '<localleader>m', require("fzf-lua").keymaps, { noremap = true, silent = true })
  end,
}
