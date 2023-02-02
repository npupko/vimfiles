return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring"
  },
  config = function()
    require'nvim-treesitter.configs'.setup {
      ensure_installed = "all",
      sync_install = false,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },

      incremental_selection = {
        enable = true,
      },

      indent = {
        enable = false
      },

      context_commentstring = {
        enable = true
      },
    }
  end
}
