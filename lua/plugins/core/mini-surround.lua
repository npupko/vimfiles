return {
  "echasnovski/mini.surround",
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
  config = function(_, opts)
    require("mini.surround").setup(opts)
    vim.keymap.del("x", "ys")
  end,
  keys = {
    { "ys", desc = "Add surrounding", mode = "n" },
    { "ds", desc = "Delete surrounding" },
    { "cs", desc = "Change surrounding" },
    { "S", [[:<C-u>lua MiniSurround.add('visual')<CR>]], mode = "x", desc = "Add surrounding" },
    { "gS", [[:<C-u>lua MiniSurround.add('visual')<CR>]], mode = "x", desc = "Add surrounding (linewise)" },
  },
}
