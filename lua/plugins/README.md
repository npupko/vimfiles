# Plugin Layout

This directory is organised for lazy.nvim and mirrors the main plugin domains.

- `core/` – always-on editing defaults (commenting, repeat, snacks, etc.).
- `lang/` – language-aware stack (Treesitter, LSP, language specific Vim plugins). The LSP entry point uses the Neovim 0.11+ `vim.lsp.config`/`vim.lsp.enable` APIs so you can drop per-server tweaks in one place without relying on the deprecated `require("lspconfig").setup()` calls.
- `tools/` – on-demand workflow helpers (Telescope, file explorers, Buddy, Fugitive, etc.).
- `ui/` – colours and cosmetic layers that need to boot early.
- `ai/` – AI assistants and completions (Tabby, Claude-Code, Amp, Copilot).
- `extras/` – opt-in experiments; they stay disabled by default but keep their specs.

Each folder has an `init.lua` that is imported from `plugins/init.lua`, so adding a new plugin is as simple as dropping a spec file in the correct directory and adding a matching `require` in that folder’s `init.lua`.

When adding new plugins try to:

1. Prefer `cmd`, `keys`, `ft`, or `event` to defer loading instead of `lazy = false`.
2. Keep expensive highlights or globals inside `config`/`init` blocks so they run only when the plugin loads.
3. Co-locate language specific plugins in `lang/` so filetype gating stays obvious.
4. For experiments, place specs in `extras/` so they can stay disabled without impacting boot time.

Use `:Lazy profile` after changes to confirm the startup budget – the current baseline is ~84 ms, with LazyDone landing around 77 ms on macOS (October 28, 2025).
