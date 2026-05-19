return {
  "echasnovski/mini.diff",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    view = { style = "sign" },
  },
  keys = {
    {
      "<leader>go",
      function() require("mini.diff").toggle_overlay(0) end,
      desc = "Toggle diff overlay",
    },
    { "]h", function() require("mini.diff").goto_hunk("next") end, desc = "Next hunk" },
    { "[h", function() require("mini.diff").goto_hunk("prev") end, desc = "Prev hunk" },
  },
}
