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

    -- tsgo (TypeScript-Go) is the TS/JS server, taken from @effect/tsgo: a tsgo
    -- build carrying the Effect language service, so Effect diagnostics ride
    -- along on the normal TS server instead of needing a second client. Effect
    -- rules only fire where a tsconfig declares the "@effect/language-service"
    -- plugin, so it behaves as plain tsgo everywhere else.
    --
    -- Always the mise-global build: it bundles its own lib.*.d.ts, so loose .ts
    -- files with no node_modules get a server too — which is what retired the
    -- ts_ls + classic-TS5 fallback this replaced.
    --
    -- Configured under nvim-lspconfig's "tsc" name: lspconfig folded its old
    -- "tsgo" config into "tsc" and kept "tsgo" only as a deprecated alias that
    -- warns on init (removed in nvim-lspconfig 3.0.0).
    vim.lsp.config("tsc", {
      cmd = function(dispatchers)
        -- nosuf=true, and vim.fs.normalize rather than expand: both glob and
        -- expand otherwise honor 'wildignore', which filters out node_modules.
        local builds = vim.fn.glob(
          vim.fs.normalize(
            "~/.local/share/mise/installs/npm-effect-tsgo/latest/node_modules/@effect/tsgo-*/artifacts/typescript/*/tsc"
          ),
          true,
          true
        )
        -- artifacts/ also ships a `next` prerelease (7.1.0-dev.*); take the
        -- newest plain x.y.z instead.
        builds = vim.tbl_filter(function(p)
          return p:match("/%d+%.%d+%.%d+/tsc$") ~= nil
        end, builds)
        table.sort(builds)
        return vim.lsp.rpc.start({ builds[#builds] or "tsgo", "--lsp", "--stdio" }, dispatchers)
      end,
    })

    vim.lsp.enable({ "lua_ls", "tsc", "jsonls", "html", "taplo", "svelte", "gopls", "marksman", "tilt_ls", "basedpyright", "terraformls" })

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
