return {
  "rebelot/kanagawa.nvim",
  enabled = false,
  config = function ()
    require('kanagawa').setup({
      undercurl = true,           -- enable undercurls
      commentStyle = { italic = true },
      functionStyle = {},
      keywordStyle = { italic = true },
      statementStyle = { bold = true },
      typeStyle = {},
      variablebuiltinStyle = { italic = true },
      specialReturn = true,       -- special highlight for the return keyword
      specialException = true,    -- special highlight for exception handling keywords
      transparent = false,        -- do not set background color
      dimInactive = false,        -- dim inactive window `:h hl-NormalNC`
      globalStatus = true,       -- adjust window separators highlight for laststatus=3
      terminalColors = false,      -- define vim.g.terminal_color_{0,17}
      colors = {},
      overrides = function ()
        return {}
      end,
      theme = "lotus"
    })
    -- vim.cmd([[colorscheme kanagawa]])
    require("kanagawa").load("wave")
  end
}
