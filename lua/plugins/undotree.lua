return {
  event = "VeryLazy",
  'mbbill/undotree',
  init = function (plugin)
    vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { noremap = true })
  end
}
