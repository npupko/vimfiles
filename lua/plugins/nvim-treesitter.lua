return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring"
  },
  config = function()
    require'nvim-treesitter.configs'.setup {
      ensure_installed = { "ruby", "rust", "tsx", "typescript", "svelte", "javascript" },
      auto_install = true,
      sync_install = false,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },

      incremental_selection = {
        enable = true,
      },

      indent = {
        enable = true
      },

      context_commentstring = {
        enable = true
      },
    }
  end,
  priority = 900,
}
