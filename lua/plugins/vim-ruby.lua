return {
  "vim-ruby/vim-ruby",
  ft = { "ruby", "erb", "rake", "rspec" },

  config = function()
    vim.g.ruby_operators = 1
    vim.g.ruby_pseudo_operators = 1
  end
}