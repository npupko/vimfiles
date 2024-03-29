vim.api.nvim_set_hl(0, 'FlashBackdrop', { link = 'Comment' })
vim.api.nvim_set_hl(0, 'FlashCurrent', { fg = 'white', bold = true, nocombine = true, })
vim.api.nvim_set_hl(0, 'FlashLabel', { fg = 'red', bold = true, nocombine = true, })
vim.api.nvim_set_hl(0, 'FlashMatch', { link = "GruvboxYellowBold" })

return {
  'folke/flash.nvim',
  event = "VeryLazy",
  ---@type Flash.Config
  opts = {
    modes = {
      search = {
        enabled = false,
      },
      char = {
        enabled = false,
      },
    }
  },
  keys = {
    {
      "s",
      mode = { "n", "x", "o" },
      function()
        -- default options: exact mode, multi window, all directions, with a backdrop
        require("flash").jump()
      end,
      desc = "Flash",
    },
    -- {
    --   "S",
    --   mode = { "n", "o", "x" },
    --   function()
    --     -- show labeled treesitter nodes around the cursor
    --     require("flash").treesitter()
    --   end,
    --   desc = "Flash Treesitter",
    -- },
    -- {
    --   "r",
    --   mode = "o",
    --   function()
    --     -- jump to a remote location to execute the operator
    --     require("flash").remote()
    --   end,
    --   desc = "Remote Flash",
    -- },
    -- {
    --   "R",
    --   mode = { "n", "o", "x" },
    --   function()
    --     -- show labeled treesitter nodes around the search matches
    --     require("flash").treesitter_search()
    --   end,
    --   desc = "Treesitter Search",
    -- }
  }
}
