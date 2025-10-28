return {
  'https://codeberg.org/esensar/nvim-dev-container',
  dependencies = 'nvim-treesitter/nvim-treesitter',
  enabled = false,
  init = function()
    require("devcontainer").setup{}
  end
}
