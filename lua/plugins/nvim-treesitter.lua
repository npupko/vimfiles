return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  enabled = true,
  config = function()
    require'nvim-treesitter.configs'.setup {
      -- ensure_installed = {
      --   "ruby",
      --   "rust",
      --   "tsx",
      --   "typescript",
      --   "svelte",
      --   "javascript",
      --   "markdown",
      --   "markdown_inline",
      --   "lua",
      --   "vim",
      --   "vimdoc",
      -- },
      -- ensure_installed = "all",
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
    }
  end,
  priority = 900,
}
