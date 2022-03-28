local cmp = require'cmp'
local lspkind = require('lspkind')

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  preselect = cmp.PreselectMode.None,
  mapping = {
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.mapping(cmp.mapping.complete(), { 'i', 'c' })
      else
        fallback()
      end
    end,
    ['<C-y>'] = cmp.config.disable,
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  formatting = {
    format = lspkind.cmp_format({
      with_text = true,
      mode = 'symbol_text',
      maxwidth = 50,
      menu = ({
        cmp_tabnine = "[T9]",
        nvim_lsp = "[LSP]",
        buffer = "[Buffer]",
        path = "[Path]",
        vsnip = "[Snip]",
      })
    })
  },
  sources = cmp.config.sources({
    { name = 'cmp_tabnine' },
    { name = 'vsnip' },
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
  })
})

