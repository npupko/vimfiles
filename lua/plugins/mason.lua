return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "jose-elias-alvarez/null-ls.nvim"
  },
  config = function()
    require("mason").setup()
    require("mason-lspconfig").setup()

    local opts = { noremap=true, silent=true }
    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', '<leader>Q', vim.diagnostic.setloclist, opts)

    -- Use an on_attach function to only map the following keys
    -- after the language server attaches to the current buffer
    local on_attach = function(_client, bufnr)
      -- Enable completion triggered by <c-x><c-o>
      vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

      -- local bufopts = { noremap=true, silent=true, buffer=bufnr }
      local bufopts = function(desc)
        return { noremap=true, silent=true, buffer=bufnr, desc=desc }
      end
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts('Go to declaration'))
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts('Go to definition'))
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts('Go to implementation'))
      vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, bufopts('Go to type definition'))
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts('Find references'))
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts('Show hover'))
      vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts('Show signature help'))
      vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts('Add workspace folder'))
      vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts('Remove workspace folder'))
      vim.keymap.set('n', '<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, bufopts('List workspace folders'))
      vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts('Rename'))
      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts('Code action'))
      vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, bufopts('Format'))
    end

    local lsp_flags = {
      -- This is the default in Nvim 0.7+
      debounce_text_changes = 150,
    }

    -- Write the code above with dictionary
    -- local servers = {
    --   "tsserver",
    --   -- "solargraph",
    --   "svelte",
    --   "ruby_ls",
    --   "tsserver",
    --   "tailwindcss",
    --   "terraformls",
    --   "rust_analyzer",
    --   "gopls",
    --   "jsonls",
    -- }

    -- for _, lsp in ipairs(servers) do
    --   require'lspconfig'[lsp].setup{
    --     on_attach = on_attach,
    --     flags = lsp_flags,
    --   }
    -- end

    require("mason-lspconfig").setup_handlers {
      -- The first entry (without a key) will be the default handler
      -- and will be called for each installed server that doesn't have
      -- a dedicated handler.
      function (server_name) -- default handler (optional)
        -- print("Setting up handlers for " .. server_name)
        require("lspconfig")[server_name].setup {
          on_attach = on_attach,
          flags = lsp_flags,
        }
      end,
    }

    -- require("null-ls").setup({
    --   sources = {
    --     require("null-ls").builtins.formatting.rubocop,
    --     require("null-ls").builtins.diagnostics.rubocop,
    --   },
    -- })

    vim.diagnostic.config({
      virtual_text = false,
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = false,
    })

    -- local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }
    -- for type, icon in pairs(signs) do
    --   local hl = "DiagnosticsSign" .. type
    --   vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    -- end

    -- Attach lsp to cmp
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
  end
}
