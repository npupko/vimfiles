return {
  'akinsho/bufferline.nvim',
  enabled = false,
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  opts = {
    options = {
      show_buffer_close_icons = false,
      show_close_icon = false,
      -- diagnostics = false | "nvim_lsp" | "coc",
      diagnostics = false,
      -- numbers = function(opts)
      --   return string.format('%s·%s', opts.raise(opts.id), opts.lower(opts.ordinal))
      -- end,
      -- numbers = "buffer_id",
    }
  }
}
