return {
  "sainnhe/gruvbox-material",
  enabled = false,
  init = function()
    vim.g.gruvbox_material_background = 'medium'
    vim.g.gruvbox_material_foreground = 'original'
    vim.g.gruvbox_material_enable_bold = 1
    vim.g.gruvbox_material_enable_italic = 1
    vim.g.gruvbox_material_transparent_background = 2
    vim.g.gruvbox_material_better_performance = 0
    vim.g.gruvbox_material_diagnostic_virtual_text = 'colored'
    vim.g.gruvbox_material_disable_terminal_colors = 1
    vim.g.gruvbox_material_statusline_style = 'original'
    vim.cmd([[colorscheme gruvbox-material]])
  end,
}
