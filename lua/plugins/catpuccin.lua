return {
  "catppuccin/nvim",
  name = "catppuccin",
  enabled = true,
  config = function ()
    require("catppuccin").setup({
      flavour = "macchiato",
    })
    vim.cmd.colorscheme "catppuccin"
  end,
  priority = 10000,
}
