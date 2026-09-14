-- Diagnostic for multi-minute hangs on `:q`. Opt in with NVIM_EXIT_TRACE=1;
-- costs nothing otherwise. Each stamp is flushed immediately so the log
-- survives an abrupt kill (`kill -9`) of a wedged Neovim.
--
-- Read the resulting gaps in ~/.local/state/nvim/exit-trace.log:
--   quitpre -> leavepre    : the :q path itself (e.g. 'confirm' prompting)
--   leavepre -> leave      : some plugin's VimLeavePre handler
--   leave -> shell prompt  : Neovim core teardown (shada, TUI, libuv)
-- Each line also dumps the libuv handles still open, so a loop that refuses to
-- drain shows up as a handle that never goes away.

local M = {}

local path = vim.env.NVIM_EXIT_TRACE_FILE or (vim.fn.stdpath("state") .. "/exit-trace.log")
local start = vim.uv.hrtime()

local function stamp(tag, extra)
  local fh = io.open(path, "a")
  if not fh then
    return
  end
  fh:write(
    ("%s pid=%-6d +%8.3fs %-18s %s\n"):format(
      os.date("%Y-%m-%d %H:%M:%S"),
      vim.uv.os_getpid(),
      (vim.uv.hrtime() - start) / 1e9,
      tag,
      extra or ""
    )
  )
  fh:close()
end

local function handle_dump()
  local counts = {}
  vim.uv.walk(function(handle)
    if not handle:is_closing() then
      local key = handle:get_type() .. (handle:is_active() and "" or ":idle")
      counts[key] = (counts[key] or 0) + 1
    end
  end)
  local parts = {}
  for key, n in pairs(counts) do
    parts[#parts + 1] = ("%s=%d"):format(key, n)
  end
  table.sort(parts)
  return table.concat(parts, " ")
end

local function on(event, tag, extra)
  vim.api.nvim_create_autocmd(event, {
    group = vim.api.nvim_create_augroup("ExitTrace." .. tag, { clear = true }),
    callback = function()
      stamp(tag, extra and extra() or nil)
    end,
  })
end

---Register the early stamps. Call before lazy.setup so these autocmds run first.
function M.setup()
  stamp("session.start", vim.fn.getcwd())
  on("QuitPre", "quitpre")
  on("ExitPre", "exitpre")
  on("VimLeavePre", "leavepre", function()
    return ("lsp=%d %s"):format(#vim.lsp.get_clients(), handle_dump())
  end)
  -- VimLeave runs after every VimLeavePre handler, so the gap above covers all
  -- of them without having to register last.
  on("VimLeave", "leave", handle_dump)
end

return M
