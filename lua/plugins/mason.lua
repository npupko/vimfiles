return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "jose-elias-alvarez/null-ls.nvim"
  },

  build = ":MasonUpdate",
  config = function()
    require("mason").setup()
    require("mason-lspconfig").setup()
    local keymap = vim.keymap.set
    local is_saga_installed = pcall(require, 'lspsaga')
    local opts = { noremap=true, silent=true }

    keymap('n', '<leader>Q', vim.diagnostic.setloclist, opts)

    if is_saga_installed then
      keymap("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
      keymap("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>")
    keymap("n", "<leader>e", "<cmd>Lspsaga show_line_diagnostics<CR>")
    else
      keymap('n', '[d', vim.diagnostic.goto_prev, opts)
      keymap('n', ']d', vim.diagnostic.goto_next, opts)
    keymap('n', '<leader>e', vim.diagnostic.open_float, opts)
    end

    -- Use an on_attach function to only map the following keys
    -- after the language server attaches to the current buffer
    local on_attach = function(_client, bufnr)
      -- Enable completion triggered by <c-x><c-o>
      vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'
      -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
      local bufopts = function(desc)
        return { noremap=true, silent=true, buffer=bufnr, desc=desc }
      end

      keymap('n', 'gD', vim.lsp.buf.declaration, bufopts('Go to declaration'))
      keymap('n', 'gi', vim.lsp.buf.implementation, bufopts('Go to implementation'))
      keymap('n', 'gy', vim.lsp.buf.type_definition, bufopts('Go to type definition'))
      keymap('n', 'gr', vim.lsp.buf.references, bufopts('Find references'))
      keymap('n', '<leader>k', vim.lsp.buf.signature_help, bufopts('Show signature help'))
      keymap('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts('Add workspace folder'))
      keymap('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts('Remove workspace folder'))
      keymap('n', '<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, bufopts('List workspace folders'))
      keymap('n', '<leader>rn', vim.lsp.buf.rename, bufopts('Rename'))
      keymap('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, bufopts('Format'))

      if is_saga_installed then
        keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>")
        keymap("n", "gp", "<cmd>Lspsaga peek_definition<CR>")

        keymap("n", "gd", "<cmd>Lspsaga goto_definition<CR>")
        keymap({"n","v"}, "<leader>ca", "<cmd>Lspsaga code_action<CR>")
        keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>")
        keymap("n", "<leader>K", "<cmd>Lspsaga hover_doc ++keep<CR>")
        keymap("n", "<leader>ol", "<cmd>Lspsaga outline<CR>")
      else
        keymap('n', 'gd', vim.lsp.buf.definition, bufopts('Go to definition'))
        keymap({'n', 'v'}, '<leader>ca', vim.lsp.buf.code_action, bufopts('Code action'))
        keymap('n', 'K', vim.lsp.buf.hover, bufopts('Show hover'))
      end
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

    -- local null_ls = require("null-ls")
    --
    -- null_ls.setup({
    --   sources = {
    --     null_ls.builtins.diagnostics.rubocop.with({
    --       command = "bundle",
    --       prefer_local = "bin",
    --       args = vim.list_extend({ "exec", "rubocop" }, null_ls.builtins.diagnostics.rubocop._opts.args),
    --     }),
    --   },
    -- })

    -- vim.diagnostic.config({
    --   virtual_text = false,
    --   signs = true,
    --   underline = true,
    --   update_in_insert = false,
    --   severity_sort = false,
    -- })

    vim.diagnostic.config({
      underline = true,
      signs = true,
      virtual_text = false,
      float = {
        show_header = false,
        source = 'if_many',
        -- format = function(_diagnostic)
        --   local message = _diagnostic.message
        --   return ' [' .. _diagnostic.source .. '] ' .. _diagnostic.message
        -- end,
        -- border = 'rounded',
        -- suffix = function (diagnostic, i, total)
        --   local base_url = "https://docs.rubocop.org/rubocop/cops_naming.html#"
        --   local code = string.lower(string.gsub(diagnostic.code, "/", ""))
        --   local link_to_code = base_url .. code
        --   return " [" .. diagnostic.code .. "]" .. link_to_code
        -- end,
        focusable = false,
      },
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
