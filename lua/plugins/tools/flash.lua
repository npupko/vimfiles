return {
  "folke/flash.nvim",
  keys = {
    {
      "s",
      mode = { "n", "x", "o" },
      function()
        require("flash").jump()
      end,
      desc = "Flash jump",
    },
  },
  opts = {
    modes = {
      search = { enabled = false },
      char = { enabled = false },
    },
  },
  config = function(_, opts)
    local set_hl = vim.api.nvim_set_hl
    set_hl(0, "FlashBackdrop", { link = "Comment" })
    set_hl(0, "FlashCurrent", { fg = "white", bold = true, nocombine = true })
    set_hl(0, "FlashLabel", { fg = "red", bold = true, nocombine = true })
    set_hl(0, "FlashMatch", { link = "GruvboxYellowBold" })
    require("flash").setup(opts)
  end,
}
