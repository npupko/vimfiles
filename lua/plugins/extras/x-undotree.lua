return {
  event = "VeryLazy",
  enabled = false,
  'mbbill/undotree',
  init = function (plugin)
    vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { noremap = true })
  end
}
