return {
  "numToStr/Comment.nvim",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  opts = function()
    local ok, integration = pcall(require, "ts_context_commentstring.integrations.comment_nvim")
    return ok and {
      pre_hook = integration.create_pre_hook(),
    } or {}
  end,
  config = function(_, opts)
    require("Comment").setup(opts)
  end,
}
