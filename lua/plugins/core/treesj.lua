return {
  "Wansmer/treesj",
  keys = {
    { "gJ", function() require("treesj").join() end, desc = "Join lines" },
    { "gS", function() require("treesj").split() end, desc = "Split line" },
  },
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  opts = {
    use_default_keymaps = false,
    max_join_length = 1000,
  },
}
