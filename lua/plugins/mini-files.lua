return {
  'echasnovski/mini.files',
  version = false,
  enabled = true,
  -- keys = {
  --   { '-', require('mini.files').open, desc = 'Open root directory with mini.files' },
  --   { '<leader>M',
  --     function ()
  --       require('mini.files').open(vim.api.nvim_buf_get_name(0))
  --     end,
  --     desc = 'Open current file in directory with mini.files'
  --   },
  -- },
  config = function ()
    local minifiles = require('mini.files')
    minifiles.setup({
      windows = {
        preview = true,
      }
    })

    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniFilesBufferCreate',
      callback = function(args)
        local buf_id = args.data.buf_id
        vim.keymap.set('n', '<CR>', minifiles.go_in, { buffer = buf_id })
      end,
    })

    vim.keymap.set('n', '-', function() require('mini.files').open(vim.api.nvim_buf_get_name(0)) end, { desc = 'Open root directory with mini.files' })
    vim.keymap.set('n', '<leader>M', function ()
      local mini = require('mini.files')
      mini.open(vim.api.nvim_buf_get_name(0))
      mini.reveal_cwd()
    end, { desc = 'Open current file in directory with mini.files' })

    -- vim.keymap.set('n', '<localleader>-', function ()
    --   local name = vim.api.nvim_buf_get_name(0)
    --   minifiles.open(name)
    --
    --   if name ~= '' then
    --     local depth = -2
    --     local _, init = name:find(vim.pesc(vim.loop.cwd() or ''))
    --     while init do
    --       depth = depth + 1
    --       init = name:find('/', init + 1)
    --     end
    --
    --     for _ = 1, depth do minifiles.go_out() end
    --     for _ = 1, depth do minifiles.go_in() end
    --   end
    -- end, { desc = 'Open root directory with mini.files and go to current file' })
  end
}
