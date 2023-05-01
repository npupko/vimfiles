return {
  "catppuccin/nvim",
  name = "catppuccin",
  enabled = false,
  config = function ()
    require("catppuccin").setup({
      flavour = "mocha",
    })
    vim.cmd.colorscheme "catppuccin"
  end,
  priority = 10000,
}
