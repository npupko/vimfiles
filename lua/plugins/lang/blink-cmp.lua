return {
  "saghen/blink.cmp",
  version = "*",
  event = "InsertEnter",
  dependencies = {
    "rafamadriz/friendly-snippets",
  },
  opts_extend = { "sources.default" },
  opts = {
    keymap = {
      preset = "default",
      ["<C-e>"] = { "select_and_accept" },
      ["<CR>"] = {},
      ["<C-d>"] = { "show", "show_documentation", "hide_documentation" },
    },
    cmdline = {
      keymap = {
        preset = "none",
      },
    },
    completion = {
      menu = {
        auto_show = function(ctx)
          return ctx.mode ~= "cmdline"
        end,
      },
    },
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "mono",
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
  },
}
