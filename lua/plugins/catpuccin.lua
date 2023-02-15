return {
  "catppuccin/nvim",
  name = "catppuccin",
  enabled = false,
  config = function ()
    require("catppuccin").setup({
      flavour = "macchiato",
    })
    vim.cmd.colorscheme "catppuccin"
  end
}
