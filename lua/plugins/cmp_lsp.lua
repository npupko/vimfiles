local icons = {
  Text = " ",
  Method = "󰆧 ",
  Function = "󰊕",
  Constructor = " ",
  Field = " ",
  Variable = "󰈜 ",
  Class = "󰠱 ",
  Interface = " ",
  Module = "󰏓 ",
  Property = "󰜢 ",
  Unit = "󰑭",
  Value = "󰎠 ",
  Enum = " ",
  Keyword = "󰌋",
  Snippet = "󰅱",
  Color = "󰏘",
  File = "󰈙",
  Reference = "󰈇",
  Folder = " ",
  EnumMember = " ",
  Constant = "󰐀",
  Struct = "󰙅",
  Event = " ",
  Operator = "󰆕",
  TypeParameter = "󰊄",
}

local formatting = {
  fields = { "kind", "abbr", "menu" },
  format = function(_, vim_item)
    vim_item.menu = vim_item.kind
    vim_item.kind = icons[vim_item.kind]

    return vim_item
  end,
}

return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-nvim-lsp",
    "L3MON4D3/LuaSnip",
    "rafamadriz/friendly-snippets"
  },
  config = function()
    local cmp_status_ok, cmp = pcall(require, "cmp")
    if not cmp_status_ok then
      return
    end

    local snip_status_ok, luasnip = pcall(require, "luasnip")
    if not snip_status_ok then
      return
    end

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body) -- For `luasnip` users.
        end,
      },
      preselect = cmp.PreselectMode.None,
      mapping = {
        ["<C-p>"] = cmp.mapping.select_prev_item(), -- For Omnifunc
        ["<C-n>"] = cmp.mapping.select_next_item(), -- For Omnifunc
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
        ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
        ["<m-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<C-y>"] = cmp.mapping {
          i = cmp.mapping.abort(),
          c = cmp.mapping.close(),
        },
        ["<Tab>"] = cmp.mapping(function(fallback)
          vim.api.nvim_feedkeys(vim.fn['copilot#Accept'](vim.api.nvim_replace_termcodes('<Tab>', true, true, true)), 'n', true)
        end),
        -- ["<C-d>"] = cmp.mapping.confirm { select = true },
        -- ["<C-y>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }), -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ["<C-e>"] = cmp.mapping.confirm { select = true },
      },
      formatting = formatting,
      sources = cmp.config.sources({
        { name = 'cmp_tabnine' },
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' },
        { name = 'path' },
      }),
      confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
      },
      experimental = {
        ghost_text = false,
        native_menu = false,
      },
    })
  end,
}
