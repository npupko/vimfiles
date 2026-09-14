return {
  -- Theming lives in lua/plugins/theme.lua, a symlink into the active theme's
  -- rendered directory (~/.local/state/theme/current/theme/neovim.lua), which
  -- lazy.nvim imports as a top-level spec file.
  require("plugins.ui.mini-icons"),
}
