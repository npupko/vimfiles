return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  build = ":MasonUpdate",
  dependencies = {
    { "williamboman/mason.nvim", config = true },
    {
      "williamboman/mason-lspconfig.nvim",
      opts = {
        automatic_enable = true,
      },
    },
    {
      "folke/neodev.nvim",
      opts = {},
    },
  },
  config = function()
    vim.diagnostic.config({
      underline = true,
      signs = true,
      virtual_text = false,
      float = {
        show_header = false,
        source = "if_many",
        focusable = true,
      },
      update_in_insert = false,
      severity_sort = false,
    })

    local keymap = vim.keymap.set
    keymap("n", "<leader>Q", vim.diagnostic.setloclist, { desc = "Quickfix diagnostics" })

    if pcall(require, "lspsaga") then
      keymap("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { desc = "Previous diagnostic" })
      keymap("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", { desc = "Next diagnostic" })
      keymap("n", "<leader>e", "<cmd>Lspsaga show_line_diagnostics<CR>", { desc = "Line diagnostics" })
    else
      keymap("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
      keymap("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
      keymap("n", "<leader>e", vim.diagnostic.open_float, { desc = "Line diagnostics" })
    end

    local function add_ruby_deps_command(client, bufnr)
      vim.api.nvim_buf_create_user_command(bufnr, "ShowRubyDeps", function(lopts)
        local params = vim.lsp.util.make_text_document_params()
        local show_all = lopts.args == "all"

        client.request("rubyLsp/workspace/dependencies", params, function(error, result)
          if error then
            vim.notify("ruby_lsp deps error: " .. error, vim.log.levels.ERROR)
            return
          end

          local qf_list = {}
          for _, item in ipairs(result or {}) do
            if show_all or item.dependency then
              table.insert(qf_list, {
                text = string.format("%s (%s) - %s", item.name, item.version, item.dependency),
                filename = item.path,
              })
            end
          end

          vim.fn.setqflist(qf_list, "r")
          vim.cmd.copen()
        end, bufnr)
      end, {
        nargs = "?",
        complete = function()
          return { "all" }
        end,
      })
    end

    local function on_attach(client, bufnr)
      vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

      local function bufmap(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
      end

      bufmap("n", "gd", vim.lsp.buf.definition, "Goto definition")
      bufmap("n", "gD", vim.lsp.buf.declaration, "Goto declaration")
      bufmap("n", "gi", vim.lsp.buf.implementation, "Goto implementation")
      bufmap("n", "gy", vim.lsp.buf.type_definition, "Goto type definition")
      bufmap("n", "gr", vim.lsp.buf.references, "Goto references")
      bufmap("n", "K", vim.lsp.buf.hover, "Hover")
      bufmap({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code actions")
      bufmap("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
      bufmap("n", "<leader>f", function()
        vim.lsp.buf.format({ async = true })
      end, "Format buffer")

      if client.name == "ruby_lsp" then
        add_ruby_deps_command(client, bufnr)
      end
    end

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local ok_blink, blink = pcall(require, "blink.cmp")
    if ok_blink and blink.get_lsp_capabilities then
      capabilities = blink.get_lsp_capabilities(capabilities)
    end

    vim.lsp.config("*", {
      capabilities = capabilities,
      flags = { debounce_text_changes = 150 },
      on_attach = on_attach,
    })
  end,
}
