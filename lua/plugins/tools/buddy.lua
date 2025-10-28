return {
  "npupko/buddy.nvim",
  dev = true,
  event = "VeryLazy",
  config = function()
    local buddy = require("buddy")
    buddy.setup({})

    vim.keymap.set("n", "<leader>/", buddy.add_debugger, { silent = true, desc = "Insert debugger" })
    vim.keymap.set("n", "<leader>cle", buddy.copy_linter_error, { silent = true, desc = "Copy linter error" })
    vim.keymap.set("n", "<leader>clb", buddy.open_linter_error_in_browser, { silent = true, desc = "Open linter error" })

    vim.api.nvim_create_user_command("Frt", buddy.prepend_file_with_magic_comment, {
      desc = "Add Ruby frozen string literal",
    })
  end,
}
