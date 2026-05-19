return {
  "folke/snacks.nvim",
  lazy = false,
  priority = 900,
  keys = {
    { "<C-p>", function() Snacks.picker.files() end, desc = "Find files" },
    { "<C-\\>", function() Snacks.picker.buffers() end, desc = "List buffers" },
    { "<localleader>o", function() Snacks.picker.recent() end, desc = "Recent files" },
    { "<leader>p", function() Snacks.picker.grep() end, desc = "Live grep" },
    { "<localleader>m", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
    { "<localleader>g", function() Snacks.picker.grep_word() end, desc = "Grep word under cursor" },
    { "<localleader>G", function() Snacks.picker.grep() end, desc = "Grep prompt" },
  },
  opts = {
    bigfile = { enabled = true },
    picker = {
      enabled = true,
      win = {
        input = {
          keys = {
            ["<Esc>"] = { "close", mode = { "n", "i" } },
          },
        },
      },
    },
    indent = {
      enabled = true,
      animate = { enabled = false },
    },
  },
}
