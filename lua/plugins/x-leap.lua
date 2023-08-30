return {
  'ggandor/leap.nvim',
  enabled = false,
  config = function ()
    require('leap').add_default_mappings()

    vim.api.nvim_set_hl(0, 'LeapBackdrop', { link = 'Comment' })
    vim.api.nvim_set_hl(0, 'LeapMatch', { fg = 'white', bold = true, nocombine = true, })
    vim.api.nvim_set_hl(0, 'LeapLabelPrimary', { fg = 'red', bold = true, nocombine = true, })
    -- vim.api.nvim_set_hl(0, 'LeapLabelPrimary', { fg = 'red', bold = true, nocombine = true, })
    vim.api.nvim_set_hl(0, 'LeapLabelSecondary', { link = "GruvboxYellowBold" })


    require('leap').opts.highlight_unlabeled_phase_one_targets = true
  end
  -- keys = {
  --   {mode = 'o', 's', '<cmd>lua require("leap").smart_send()<CR>'},
  --   {mode = 'o', 'S', '<cmd>lua require("leap").send()<CR>'},
  --   {mode = 'x', 's', '<cmd>lua require("leap").smart_send()<CR>'},
  --   {mode = 'x', 'S', '<cmd>lua require("leap").send()<CR>'},
  -- }
}
