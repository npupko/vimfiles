-- convert packer import to Lazy
--   use { 'ellisonleao/gruvbox.nvim' }

return {
  'ellisonleao/gruvbox.nvim',
  config = function()
    vim.cmd([[colorscheme gruvbox]])
  end,
  priority = 10000,
}
