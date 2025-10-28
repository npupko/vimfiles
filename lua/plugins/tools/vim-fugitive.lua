return {
  "tpope/vim-fugitive",
  cmd = { "Git", "G" },
  keys = {
    { "<leader>fh", "<cmd>0Gclog<CR>", desc = "Git file history" },
    { "gh", "<cmd>diffget //2<CR>", desc = "Diff get ours" },
    { "gl", "<cmd>diffget //3<CR>", desc = "Diff get theirs" },
  },
}
