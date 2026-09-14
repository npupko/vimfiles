-- Claude Code runs OUTSIDE Neovim (its own tmux pane). Neovim is only the IDE
-- side of the integration: it runs the WebSocket server, advertises a lock file
-- in ~/.claude/ide/, streams selection/diagnostics, and renders diffs.
--
-- To connect: start `claude` in another pane from the same project and run
-- `/ide` (or launch it as `claude --ide`).

---Focus the tmux pane running Claude, so a send lands where you'll type next.
---No-ops outside tmux or when no candidate pane is found.
local focus_claude_pane = function()
  if not vim.env.TMUX then
    return
  end
  vim.system({ "tmux", "list-panes", "-F", "#{pane_id}\t#{pane_current_command}\t#{pane_title}" }, {
    text = true,
  }, function(out)
    if out.code ~= 0 then
      return
    end
    local panes, target = {}, nil
    for line in out.stdout:gmatch("[^\n]+") do
      local id, cmd, title = line:match("^(%S+)\t([^\t]*)\t(.*)$")
      if id then
        panes[#panes + 1] = id
        -- Claude Code sets the pane title to "✳ <task summary>".
        if title:find("✳", 1, true) and cmd ~= "nvim" then
          target = id
        end
      end
    end
    -- Fallback for the common nvim-plus-Claude two-pane window.
    if not target and #panes == 2 then
      target = panes[1] == vim.env.TMUX_PANE and panes[2] or panes[1]
    end
    if target and target ~= vim.env.TMUX_PANE then
      vim.system({ "tmux", "select-pane", "-t", target })
    end
  end)
end

return {
  "coder/claudecode.nvim",
  -- Load eagerly-ish: the server must be listening before you run `/ide` in the
  -- external CLI, so this cannot be keymap-lazy.
  event = "VeryLazy",
  enabled = false,
  opts = {
    -- Silence the INFO "integration started/stopped" echoes. At the default
    -- "info" level the plugin nvim_echo's on VimLeavePre, which is the only UI
    -- work it does during shutdown; "warn" makes that path early-return so exit
    -- stays clean (warnings/errors still surface).
    log_level = "warn",
    -- Pin a narrow band instead of the 10000-65535 default: the CLI reads the
    -- port from the lock file, and a fixed range keeps the server off ports
    -- other local HTTP clients probe (dev servers, stale browser tabs), whose
    -- non-WebSocket GETs otherwise show up as handshake-failure warnings.
    port_range = { min = 45000, max = 45010 },
    terminal = {
      provider = "none", -- no UI actions; server + tools remain available
    },
    -- The whole point of the integration when the CLI lives elsewhere.
    track_selection = true,
    -- Has no effect with provider = "none" (nothing in-editor to focus); the
    -- ClaudeCodeSendComplete hook below does the equivalent for the tmux pane.
    focus_after_send = false,
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "ClaudeCodeSendComplete",
      group = vim.api.nvim_create_augroup("ClaudeCodeExternalFocus", { clear = true }),
      callback = function()
        -- Fires once per file; coalesce multi-file sends into one tmux call.
        vim.schedule(focus_claude_pane)
      end,
    })
  end,
  keys = {
    { "<leader>a", nil, desc = "AI/Claude Code" },
    { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send selection to Claude" },
    {
      "<leader>as",
      "<cmd>ClaudeCodeTreeAdd<cr>",
      desc = "Add file to Claude context",
      ft = { "NvimTree", "neo-tree", "oil", "minifiles" },
    },
    {
      "<leader>af",
      -- User commands do not expand `%`, so resolve the path here.
      function()
        vim.cmd("ClaudeCodeAdd " .. vim.fn.fnameescape(vim.fn.expand("%:p")))
      end,
      desc = "Add current file to Claude context",
    },
    { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept Claude Code diff" },
    { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny Claude Code diff" },
    -- Diffs resolved outside this Neovim (remote control, another client) leave
    -- pending proposals behind; this clears them without touching saved edits.
    { "<leader>aq", "<cmd>ClaudeCodeCloseAllDiffs<cr>", desc = "Close pending Claude diffs" },
    {
      "<leader>a?",
      function()
        -- :ClaudeCodeStatus logs at "info", which log_level = "warn" swallows.
        local status = require("claudecode.server.init").get_status()
        vim.notify(
          status.running
              and ("Claude Code: port %d, %d client(s)"):format(status.port, status.client_count)
            or "Claude Code: not running",
          vim.log.levels.INFO
        )
      end,
      desc = "Claude Code connection status",
    },
  },
}
