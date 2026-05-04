-- Suppress harmless NO_RESULT_CALLBACK_FOUND noise from servers that reply to
-- cancelled requests (ruby-lsp semanticTokens, taplo, etc.). See
-- https://github.com/neovim/neovim/issues/11515 — Neovim's default _on_error
-- writes the message to :messages before the user on_error callback can run,
-- so we override the instance method per-client at on_init.
local function suppress_orphan_response_errors(client)
  local nrcb = vim.lsp.rpc.client_errors.NO_RESULT_CALLBACK_FOUND
  local original = client._on_error
  client._on_error = function(self, code, err)
    if code == nrcb then
      return
    end
    return original(self, code, err)
  end
end

return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { "folke/lazydev.nvim", ft = "lua", opts = {} },
  },
  config = function()
    vim.lsp.config("taplo", { on_init = suppress_orphan_response_errors })

    vim.lsp.enable({ "lua_ls", "ts_ls", "jsonls", "html", "taplo", "svelte", "gopls", "marksman" })

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
      end,
    })
  end,
}
