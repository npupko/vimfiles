vim.lsp.enable({ "lua_ls", "ruby_lsp", "ts_ls", "jsonls", "html", "taplo", "svelte" })

return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { "folke/lazydev.nvim", ft = "lua", opts = {} },
  },
  config = function()
    vim.diagnostic.config({
      underline = true,
      signs = true,
      virtual_text = false,
      float = {
        source = "if_many",
        focusable = true,
      },
      update_in_insert = false,
      severity_sort = true,
    })

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("user-lsp-keymaps", { clear = true }),
      callback = function(ev)
        -- Native LSP completion (Neovim 0.12)
        vim.lsp.completion.enable(true, ev.data.client_id, ev.buf, { autotrigger = true })

        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, silent = true, desc = desc })
        end

        -- Built-in 0.11 defaults handle: K (hover), [d/]d (diagnostics),
        -- grn (rename), gra (code action), grr (references), gri (implementation)
        map("n", "gd", vim.lsp.buf.definition, "Goto definition")
        map("n", "gD", vim.lsp.buf.declaration, "Goto declaration")
        map("n", "gy", vim.lsp.buf.type_definition, "Goto type definition")
        map("n", "<leader>f", function()
          vim.lsp.buf.format({ async = true })
        end, "Format buffer")
        map("n", "<leader>e", vim.diagnostic.open_float, "Line diagnostics")
        map("n", "<leader>Q", vim.diagnostic.setloclist, "Quickfix diagnostics")

        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client and client.name == "ruby_lsp" then
          vim.api.nvim_buf_create_user_command(ev.buf, "ShowRubyDeps", function(opts)
            local params = vim.lsp.util.make_text_document_params()
            local show_all = opts.args == "all"

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
            end, ev.buf)
          end, {
            nargs = "?",
            complete = function()
              return { "all" }
            end,
          })
        end
      end,
    })
  end,
}
