vim.g.matchup_matchparen_offscreen = { method = 'popup' }

return {
  'andymass/vim-matchup',
  enabled = true,
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  config = function ()
    require'nvim-treesitter.configs'.setup {
      matchup = {
        enable = true
      },
    }
    -- vim.cmd("highlight! link MatchParen GruvboxPurpleSign")
    -- vim.cmd("highlight! link MatchWord GruvboxOrangeBold")
  end,
  priority = 10001,
}
