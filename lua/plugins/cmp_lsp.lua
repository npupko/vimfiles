local lspkind = require('lspkind')
local luasnip = require'luasnip'

-- vim.keymap.set('i', '<C-x><C-o>', require('cmp').complete)

vim.opt.completeopt = 'menu,menuone,noselect'

local cmp = require'cmp'

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  preselect = cmp.PreselectMode.None,
  mapping = {
    ['<C-c>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.mapping.close()
        fallback()
      else
        fallback()
      end
    end),
    ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
		['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
  --   ['<C-p>'] = cmp.mapping.select_prev_item(),
		-- ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() and cmp.get_selected_entry() ~= nil then
        cmp.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        })
      elseif cmp.visible() and cmp.get_selected_entry() == nil then
        cmp.select_next_item()
        cmp.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        })
      else
        fallback()
      end
    end, { "i", "s" }),
    ['<C-y>'] = cmp.config.disable,
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    -- ['<CR>'] = function(fallback)
    --   if cmp.visible() then
    --     cmp.confirm({ select = true })
    --   else
    --     fallback()
    --   end
    -- end,
  },
  formatting = {
    format = lspkind.cmp_format({
      with_text = true,
      mode = 'symbol_text',
      maxwidth = 60,
      menu = ({
        cmp_tabnine = "[T9]",
        nvim_lsp = "[LSP]",
        buffer = "[Buffer]",
        path = "[Path]",
        -- vsnip = "[Snip]",
        luasnip = "[Snip]",
      })
    })
  },
  -- completion = {
  --   autocomplete = true
  -- },
  experimental = {
    ghost_text = false
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  sources = cmp.config.sources({
    { name = 'cmp_tabnine' },
    { name = 'luasnip' },
    { name = 'nvim_lsp' },
    { name = 'path' },
  }, {
    { name = 'buffer' },
  }),
  -- sorting = {
  --   priority_weight = 2,
  --   comparators = {
  --     require('cmp_tabnine.compare'),
  --     compare.offset,
  --     compare.exact,
  --     compare.score,
  --     compare.recently_used,
  --     compare.kind,
  --     compare.sort_text,
  --     compare.length,
  --     compare.order,
  --   },
  -- },
})
