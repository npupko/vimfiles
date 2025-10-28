-- return {
--   "greggh/claude-code.nvim",
--   enabled = false,
--   dependencies = {
--     "nvim-lua/plenary.nvim", -- Required for git operations
--   },
--   config = function()
--     require("claude-code").setup()
--   end
-- }

return {
  "coder/claudecode.nvim",
  event = "VeryLazy",
  opts = {
    terminal = {
      provider = "none", -- no UI actions; server + tools remain available
    },
  },
  enabled = true,
  keys = {
    { "<leader>a", nil, desc = "AI/Claude Code" },
    -- { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
    -- { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
    -- { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
    -- { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
    { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
    { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept Claude Code diff" },
    { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny Claude Code diff" },
    {
      "<leader>as",
      "<cmd>ClaudeCodeTreeAdd<cr>",
      desc = "Add file",
      ft = { "NvimTree", "neo-tree" },
    }
  }
}
