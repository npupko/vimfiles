return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("nvim-treesitter.configs").setup({
      textobjects = {
        lsp_interop = {
          enable = true,
          border = "none",
          floating_preview_opts = {},
          peek_definition_code = {
            ["<leader>df"] = "@function.outer",
            ["<leader>dF"] = "@class.outer",
          },
        },
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            af = { query = "@function.outer", desc = "Function outer" },
            am = { query = "@function.outer", desc = "Method outer" },
            ["if"] = { query = "@function.inner", desc = "Function inner" },
            im = { query = "@function.inner", desc = "Method inner" },
            ac = { query = "@class.outer", desc = "Class outer" },
            ic = { query = "@class.inner", desc = "Class inner" },
            as = { query = "@scope", query_group = "locals", desc = "Scope" },
          },
          selection_modes = {
            ["@parameter.outer"] = "v",
            ["@function.outer"] = "V",
            ["@class.outer"] = "<c-v>",
          },
          include_surrounding_whitespace = false,
        },
      },
    })
  end,
}
