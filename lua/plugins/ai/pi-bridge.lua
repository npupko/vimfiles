return {
  dir = "~/.pi/agent/extensions/nvim-bridge",
  name = "pi",
  enabled = false,
  event = "VeryLazy",
  config = function()
    require("pi").setup()
  end,
  keys = {
    {
      "<leader>Pr",
      ":PiPromptSelection<CR>",
      mode = "x",
      desc = "pi: append selection to prompt",
    },
    {
      "<leader>Pa",
      ":PiSend ",
      desc = "pi: send message",
    },
  },
}
