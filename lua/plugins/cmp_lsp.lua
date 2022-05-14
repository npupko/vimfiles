-- local luasnip = require'luasnip'
--
--
-- vim.opt.completeopt = 'menu,menuone,noselect'
--
-- local cmp = require'cmp'
--
-- cmp.setup({
--   snippet = {
--     expand = function(args)
--       luasnip.lsp_expand(args.body)
--     end,
--   },
--   preselect = cmp.PreselectMode.None,
--   mapping = {
--     -- ['<C-c>'] = cmp.mapping(function(fallback)
--     --   if cmp.visible() then
--     --     cmp.mapping.close()
--     --     fallback()
--     --   else
--     --     fallback()
--     --   end
--     -- end),
--     ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
-- 		['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
--   --   ['<C-p>'] = cmp.mapping.select_prev_item(),
-- 		-- ['<C-n>'] = cmp.mapping.select_next_item(),
--     ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
--     ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
--     ["<Tab>"] = cmp.mapping(function(fallback)
--       if cmp.visible() and cmp.get_selected_entry() ~= nil then
--         cmp.confirm({
--           behavior = cmp.ConfirmBehavior.Replace,
--           select = true,
--         })
--       elseif cmp.visible() and cmp.get_selected_entry() == nil then
--         cmp.select_next_item()
--         cmp.confirm({
--           behavior = cmp.ConfirmBehavior.Replace,
--           select = true,
--         })
--       else
--         fallback()
--       end
--     end, { "i", "s" }),
--     ['<C-y>'] = cmp.config.disable,
--     ['<C-e>'] = cmp.mapping({
--       i = cmp.mapping.abort(),
--       c = cmp.mapping.close(),
--     }),
--     -- ['<CR>'] = function(fallback)
--     --   if cmp.visible() then
--     --     cmp.confirm({ select = true })
--     --   else
--     --     fallback()
--     --   end
--     -- end,
--   },
--   formatting = {
--     format = lspkind.cmp_format({
--       with_text = true,
--       mode = 'symbol_text',
--       maxwidth = 60,
--       menu = ({
--         cmp_tabnine = "[T9]",
--         nvim_lsp = "[LSP]",
--         buffer = "[Buffer]",
--         path = "[Path]",
--         -- vsnip = "[Snip]",
--         luasnip = "[Snip]",
--       })
--     })
--   },
--   -- completion = {
--   --   autocomplete = true
--   -- },
--   experimental = {
--     ghost_text = false
--   },
--   window = {
--     -- completion = cmp.config.window.bordered(),
--     -- documentation = cmp.config.window.bordered(),
--   },
--   sources = cmp.config.sources({
--     { name = 'cmp_tabnine' },
--     { name = 'luasnip' },
--     { name = 'nvim_lsp' },
--     { name = 'path' },
--   }, {
--     { name = 'buffer' },
--   }),
--   -- sorting = {
--   --   priority_weight = 2,
--   --   comparators = {
--   --     require('cmp_tabnine.compare'),
--   --     compare.offset,
--   --     compare.exact,
--   --     compare.score,
--   --     compare.recently_used,
--   --     compare.kind,
--   --     compare.sort_text,
--   --     compare.length,
--   --     compare.order,
--   --   },
--   -- },
-- })
--
-- ==========================================================
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
  return
end

local lspkind = require'lspkind'

vim.keymap.set('i', '<C-x><C-o>', require('cmp').complete)

local check_backspace = function()
  local col = vim.fn.col "." - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

local icons = {
  Text = " ",
  Method = " ",
  Function = " ",
  Constructor = " ",
  Field = " ",
  Variable = " ",
  Class = "ﴯ ",
  Interface = " ",
  Module = " ",
  Property = "ﰠ ",
  Unit = "塞 ",
  Value = " ",
  Enum = " ",
  Keyword = " ",
  -- Keyword = "廓 ",
  Snippet = " ",
  Color = " ",
  File = " ",
  Reference = " ",
  Folder = " ",
  EnumMember = " ",
  Constant = " ",
  Struct = "פּ ",
  Event = " ",
  Operator = " ",
  TypeParameter = " ",
}

-- local formatting = {
--   format = lspkind.cmp_format({
--     with_text = true,
--     mode = 'symbol_text',
--     maxwidth = 60,
--     menu = ({
--       cmp_tabnine = "[T9]",
--       nvim_lsp = "[LSP]",
--       buffer = "[Buffer]",
--       path = "[Path]",
--       luasnip = "[Snip]",
--     })
--   })
-- }

local formatting = {
  fields = { "kind", "abbr", "menu" },
  format = function(_, vim_item)
    vim_item.menu = vim_item.kind
    vim_item.kind = icons[vim_item.kind]

    return vim_item
  end,
}

--   פּ ﯟ   some other good icons
-- local kind_icons = {
--   Text = "",
--   Method = "m",
--   Function = "",
--   Constructor = "",
--   Field = "",
--   Variable = "",
--   Class = "",
--   Interface = "",
--   Module = "",
--   Property = "",
--   Unit = "",
--   Value = "",
--   Enum = "",
--   Keyword = "",
--   Snippet = "",
--   Color = "",
--   File = "",
--   Reference = "",
--   Folder = "",
--   EnumMember = "",
--   Constant = "",
--   Struct = "",
--   Event = "",
--   Operator = "",
--   TypeParameter = "",
-- }
-- find more here: https://www.nerdfonts.com/cheat-sheet

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  preselect = cmp.PreselectMode.None,
  mapping = {
    -- ['<C-l>'] = cmp.mapping(function(fallback)
    --   vim.api.nvim_feedkeys(vim.fn['copilot#Accept'](vim.api.nvim_replace_termcodes('<Tab>', true, true, true)), 'n', true)
    -- end),
    ["<C-p>"] = cmp.mapping.select_prev_item(), -- For Omnifunc
		["<C-n>"] = cmp.mapping.select_next_item(), -- For Omnifunc
  --   ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
		-- ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
    ["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
    ["<m-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-y>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }), -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ["<C-e>"] = cmp.mapping {
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    },
    ["<Tab>"] = cmp.mapping(function(fallback)
      vim.api.nvim_feedkeys(vim.fn['copilot#Accept'](vim.api.nvim_replace_termcodes('<Tab>', true, true, true)), 'n', true)
    end),
    -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ["<CR>"] = cmp.mapping.confirm { select = true },
    -- ["<Tab>"] = cmp.mapping(function(fallback)
    --   if cmp.visible() then
    --     cmp.select_next_item()
    --   elseif luasnip.expandable() then
    --     luasnip.expand()
    --   elseif luasnip.expand_or_jumpable() then
    --     luasnip.expand_or_jump()
    --   elseif check_backspace() then
    --     fallback()
    --   else
    --     fallback()
    --   end
    -- end, {
    --   "i",
    --   "s",
    -- }),
    -- ["<S-Tab>"] = cmp.mapping(function(fallback)
    --   if cmp.visible() then
    --     cmp.select_prev_item()
    --   elseif luasnip.jumpable(-1) then
    --     luasnip.jump(-1)
    --   else
    --     fallback()
    --   end
    -- end, {
    --   "i",
    --   "s",
    -- }),
  },
  formatting = formatting,
  -- formatting = {
  --   fields = { "kind", "abbr", "menu" },
  -- --   format = function(entry, vim_item)
  --     -- Kind icons
  --     vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
  --     -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
  --     vim_item.menu = ({
  --       nvim_lsp = "[LSP]",
  --       luasnip = "[Snippet]",
  --       buffer = "[Buffer]",
  --       path = "[Path]",
  --     })[entry.source.name]
  --     return vim_item
  --   end,
  -- },
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
  -- window = {
  --   completion = cmp.config.window.bordered(),
  --   documentation = cmp.config.window.bordered(),
  -- },
  experimental = {
    ghost_text = false,
    native_menu = false,
  },
  -- completion = {
  --   autocomplete = false
  -- }
}
