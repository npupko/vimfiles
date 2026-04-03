return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  branch = "main",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("nvim-treesitter-textobjects").setup({
      select = {
        lookahead = true,
        selection_modes = {
          ["@parameter.outer"] = "v",
          ["@function.outer"] = "V",
          ["@class.outer"] = "<c-v>",
        },
        include_surrounding_whitespace = false,
      },
    })
    local sel = "nvim-treesitter-textobjects.select"
    local m = { "x", "o" }
    vim.keymap.set(m, "af", function() require(sel).select_textobject("@function.outer", "textobjects") end, { desc = "Function outer" })
    vim.keymap.set(m, "am", function() require(sel).select_textobject("@function.outer", "textobjects") end, { desc = "Method outer" })
    vim.keymap.set(m, "if", function() require(sel).select_textobject("@function.inner", "textobjects") end, { desc = "Function inner" })
    vim.keymap.set(m, "im", function() require(sel).select_textobject("@function.inner", "textobjects") end, { desc = "Method inner" })
    vim.keymap.set(m, "ac", function() require(sel).select_textobject("@class.outer", "textobjects") end, { desc = "Class outer" })
    vim.keymap.set(m, "ic", function() require(sel).select_textobject("@class.inner", "textobjects") end, { desc = "Class inner" })
    vim.keymap.set(m, "as", function() require(sel).select_textobject("@local.scope", "locals") end, { desc = "Scope" })
  end,
}
