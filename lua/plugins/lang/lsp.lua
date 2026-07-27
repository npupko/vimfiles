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
    -- Detect Tiltfile as filetype so tilt_ls attaches
    vim.filetype.add({
      filename = {
        ["Tiltfile"] = "tiltfile",
        ["Tiltfile.k8s"] = "tiltfile",
      },
    })

    vim.lsp.config("taplo", { on_init = suppress_orphan_response_errors })

    -- typescript-language-server needs a classic tsserver.js. The mise-global
    -- `npm:typescript` primary is TS7 (native tsgo, no tsserver.js), and loose
    -- .ts files (e.g. ~/.pi extensions) have no local node_modules to fall back
    -- on, so the server would exit with "Could not find a valid TypeScript
    -- installation". Point it at the mise-installed classic TS5 lib as a global
    -- fallback (see programs.mise npm:typescript = [ "latest" "5" ] in home.nix).
    vim.lsp.config("ts_ls", {
      init_options = {
        hostInfo = "neovim",
        tsserver = {
          -- vim.fs.normalize (not vim.fn.expand): expand/glob honor 'wildignore'
          -- which filters node_modules, yielding an empty path.
          path = vim.fs.normalize("~/.local/share/mise/installs/npm-typescript/5/node_modules/typescript/lib"),
        },
      },
    })

    vim.lsp.enable({ "lua_ls", "ts_ls", "jsonls", "html", "taplo", "svelte", "gopls", "marksman", "tilt_ls", "basedpyright" })

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
