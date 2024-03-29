require("mason").setup()
require("mason-lspconfig").setup()

local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

require'lspconfig'.tsserver.setup{
    on_attach = on_attach,
    flags = lsp_flags,
}

-- require'lspconfig'.ruby_ls.setup{
--   on_attach = on_attach,
--   flags = lsp_flags,
--   init_options = {
--     enabledFeatures = { "codeActions", "diagnostics", "documentHighlights", "documentSymbols", "formatting", "inlayHint" }
--   }
-- }

require'lspconfig'.solargraph.setup{
  on_attach = on_attach,
  flags = lsp_flags,
}

require'lspconfig'.svelte.setup{
  on_attach = on_attach,
  flags = lsp_flags,
}

require'lspconfig'.tsserver.setup{
  on_attach = on_attach,
  flags = lsp_flags,
}

require'lspconfig'.tailwindcss.setup{
  on_attach = on_attach,
  flags = lsp_flags,
}

require'lspconfig'.terraformls.setup{
  on_attach = on_attach,
  flags = lsp_flags,
}

require 'lspconfig'.rust_analyzer.setup{
  on_attach = on_attach,
  flags = lsp_flags,
}

require 'lspconfig'.gopls.setup{
  on_attach = on_attach,
  flags = lsp_flags,
}

require'lspconfig'.eslint.setup{
  cmd = { "eslint_d", "--stdio" },
  on_attach = on_attach,
  flags = lsp_flags,
  filetypes = {
    'javascript',
    'javascriptreact',
    'javascript.jsx',
    'typescript',
    'typescriptreact',
    'typescript.tsx',
    'svelte',
  },
}

require("null-ls").setup({
    sources = {
        require("null-ls").builtins.formatting.rubocop,
        require("null-ls").builtins.diagnostics.rubocop,
    },
})

vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = false,
})
