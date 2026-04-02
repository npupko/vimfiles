return {
  "andymass/vim-matchup",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  init = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "sh", "bash" },
      callback = function()
        vim.b.matchup_matchparen_enabled = 0
      end,
    })
  end,
}
