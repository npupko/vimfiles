return {
  "echasnovski/mini.surround",
  event = "VeryLazy",
  opts = {
    respect_selection_type = true,
    mappings = {
      add = "ys",
      delete = "ds",
      replace = "cs",
      find = "",
      find_left = "",
      highlight = "",
      update_n_lines = "",
      suffix_last = "",
      suffix_next = "",
    },
  },
  keys = {
    { "S", [[:<C-u>lua MiniSurround.add('visual')<CR>]], mode = "x", desc = "Add surrounding" },
    { "gS", [[:<C-u>lua MiniSurround.add('visual')<CR>]], mode = "x", desc = "Add surrounding (linewise)" },
  },
}
