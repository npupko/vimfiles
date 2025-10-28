return {
  "janko-m/vim-test",
  keys = {
    { "<leader>tn", ":TestNearest<CR>", desc = "Run nearest test" },
    { "<leader>tf", ":TestFile<CR>", desc = "Run test file" },
    { "<leader>ts", ":TestSuite<CR>", desc = "Run test suite" },
    { "<leader>tl", ":TestLast<CR>", desc = "Re-run last test" },
    { "<leader>tg", ":TestVisit<CR>", desc = "Visit test file" },
  },
  cmd = { "TestNearest", "TestFile", "TestSuite", "TestLast", "TestVisit" },
  config = function()
    vim.g["test#strategy"] = "neovim"
    vim.g["test#runner_commands"] = { "RSpec" }
    vim.g["test#javascript#runner"] = "jest"
  end,
}
