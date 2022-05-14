local dap_install = require("dap-install")

local dap = require("dap")
-- dap.defaults.fallback.external_terminal = {
--   command = "/home/random/.local/bin/kitty",
--   args = { "-e" },
-- }
dap.defaults.fallback.force_external_terminal = true
dap.defaults.fallback.terminal_win_cmd = '50vsplit new'

dap_install.setup({
  installation_path = "/tmp/test_dap_install/",
  verbosely_call_debuggers = true,
})

dap_install.config('ruby_vsc_dbg', {
  configurations = {
    {
      name = "Debug Attach",
      type = "ruby",
      request = "attach",
      cwd = "/Users/random/Projects/github/DealMakerTech/dealmaker-rails",
      remoteWorkspaceRoot = "/Users/random/Projects/github/DealMakerTech/dealmaker-rails",
      remoteHost = "0.0.0.0",
      remotePort = "1234"
    },
    {
      name = "Rails Server";
      type = "ruby";
      console = "externalTerminal",
      request = "launch";
      cwd = "${workspaceFolder}";
      useBundler = true;
      pathToBundler = "/Users/random/.rbenv/shims/bundle";
      pathToRDebugIDE = "/Users/random/.rbenv/shims/rdebug-ide";
      showDebuggerOutput = true;
      program = "${workspaceFolder}/bin/rails",
      args = { "s" };
    },
  }
})

vim.keymap.set("n", "<localleader>d", dap.toggle_breakpoint)
vim.keymap.set("n", "<localleader>c", dap.continue)
vim.keymap.set("n", "<localleader>n", dap.step_over)
vim.keymap.set("n", "<localleader>s", dap.step_into)
vim.keymap.set("n", "<localleader>w", dap.step_out)
vim.keymap.set("n", "<localleader>r", dap.repl.toggle)

vim.keymap.set("n", "<localleader>u", require("dapui").toggle)

-- nnoremap <silent> <F5> <Cmd>lua require'dap'.continue()<CR>
-- nnoremap <silent> <F10> <Cmd>lua require'dap'.step_over()<CR>
-- nnoremap <silent> <F11> <Cmd>lua require'dap'.step_into()<CR>
-- nnoremap <silent> <F12> <Cmd>lua require'dap'.step_out()<CR>
--
-- nnoremap <silent> <Leader>b <Cmd>lua require'dap'.toggle_breakpoint()<CR>
-- nnoremap <silent> <Leader>B <Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
-- nnoremap <silent> <Leader>lp <Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
-- nnoremap <silent> <Leader>dr <Cmd>lua require'dap'.repl.open()<CR>
-- nnoremap <silent> <Leader>dl <Cmd>lua require'dap'.run_last()<CR>

--
-- -- dap.ext.vscode.load_launchjs({path}, {type_to_filetypes})
-- -- require('dap.ext.vscode').load_launchjs(nil, { cppdbg = {'c', 'cpp'} })
-- -- require('dap.ext.vscode').load_launchjs()
--
-- dap.defaults.fallback.external_terminal = {
  --   command = "/home/random/.local/bin/kitty",
  --   args = { "-e" },
  -- }
  --
  -- dap.set_log_level('debug')
  -- dap.adapters.ruby = {
    --   type = 'executable';
    --   command = 'bundle';
    --   args = {'exec', 'readapt', 'stdio'};
    -- }
    -- -- --
    -- -- -- dap.adapters.ruby = {
      -- -- --   args = { "/Users/random/.config/nvim/lua/plugins/ruby_stuff/extension/dist/debugger/main.js" },
      -- -- --   command = "node",
      -- -- --   type = "executable"
      -- -- -- }
      -- --
      -- dap.configurations.ruby = {
        --   {
          --     type = 'ruby';
          --     request = 'launch';
          --     name = 'Rails';
          --     program = 'bundle';
          --     console = "externalTerminal",
          --     programArgs = {'exec', 'rails', 's'};
          --     useBundler = true;
          --   },
          --   {
            --     type = 'ruby';
            --     request = 'attach';
            --     name = 'Rails';
            --     program = 'bundle';
            --     programArgs = {'exec', 'rails', 's'};
            --     useBundler = true;
            --   },
            -- }
            -- --
            -- -- dap.configurations.ruby = {
              -- --   {
                -- --     name = "Start Rails server",
                -- --     type = "ruby",
                -- --     request = "launch",
                -- --     cwd = "/Users/random/Projects/github/DealMakerTech/dealmaker-rails",
                -- --     program = "/Users/random/Projects/github/DealMakerTech/dealmaker-rails/bin/rails",
                -- --     args = {
                  -- --       "server",
                  -- --       "-p",
                  -- --       "3000"
                  -- --     }
                  -- --   },
                  -- --   {
                    -- --     name = "Debug Rails server",
                    -- --     type = "ruby",
                    -- --     request = "launch",
                    -- --     cwd = "/Users/random/Projects/github/DealMakerTech/dealmaker-rails",
                    -- --     useBundler = true,
                    -- --     pathToBundler = "/Users/random/.rbenv/shims/bundle",
                    -- --     pathToRDebugIDE = "/Users/random/.rbenv/versions/2.7.2/lib/ruby/gems/2.7.0/gems/ruby-debug-ide-0.7.0/bin/rdebug-ide",
                    -- --     program = "rails",
                    -- --     args = {
                      -- --       "server",
                      -- --       "-p",
                      -- --       "3000"
                      -- --     }
                      -- --   },
                      -- --   {
                        -- --     name = "Debug Attach",
                        -- --     type = "ruby",
                        -- --     request = "attach",
                        -- --     cwd = "/Users/random/Projects/github/DealMakerTech/dealmaker-rails",
                        -- --     remoteWorkspaceRoot = "/Users/random/Projects/github/DealMakerTech/dealmaker-rails",
                        -- --     remoteHost = "0.0.0.0",
                        -- --     remotePort = "1488"
                        -- --   }
                        -- -- }

require("dapui").setup({
  icons = { expanded = "▾", collapsed = "▸" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  -- Expand lines larger than the window
  -- Requires >= 0.7
  expand_lines = vim.fn.has("nvim-0.7"),
  sidebar = {
    -- You can change the order of elements in the sidebar
    elements = {
      -- Provide as ID strings or tables with "id" and "size" keys
      {
        id = "scopes",
        size = 0.25, -- Can be float or integer > 1
      },
      { id = "breakpoints", size = 0.25 },
      { id = "stacks", size = 0.25 },
      { id = "watches", size = 00.25 },
    },
    size = 40,
    position = "left", -- Can be "left", "right", "top", "bottom"
  },
  tray = {
    elements = { "repl" },
    size = 10,
    position = "bottom", -- Can be "left", "right", "top", "bottom"
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    border = "single", -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
  render = {
    max_type_length = nil, -- Can be integer or nil.
  }
})
