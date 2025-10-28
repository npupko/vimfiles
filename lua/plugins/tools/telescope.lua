local function has_make()
  return vim.fn.executable("make") == 1
end

return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  keys = {
    { "<C-p>", function() require("telescope.builtin").find_files() end, desc = "Find files" },
    { "<C-\\>", function() require("telescope.builtin").buffers({ sort_mru = true }) end, desc = "List buffers" },
    { "<localleader>o", function() require("telescope.builtin").oldfiles() end, desc = "Recent files" },
    { "<leader>p", function() require("telescope.builtin").live_grep() end, desc = "Live grep" },
    { "<localleader>m", function() require("telescope.builtin").keymaps() end, desc = "Keymaps" },
    {
      "<localleader>g",
      function()
        require("telescope.builtin").grep_string({ search = vim.fn.expand("<cword>") })
      end,
      desc = "Grep word under cursor",
    },
    {
      "<localleader>G",
      function()
        vim.ui.input({ prompt = "Grep > " }, function(value)
          if value and #value > 0 then
            require("telescope.builtin").grep_string({ search = value })
          end
        end)
      end,
      desc = "Grep prompt",
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = has_make() and "make" or nil },
  },
  opts = {
    defaults = {
      mappings = {
        i = {
          ["<esc>"] = require("telescope.actions").close,
          ["<C-j>"] = require("telescope.actions").move_selection_next,
          ["<C-k>"] = require("telescope.actions").move_selection_previous,
        },
      },
      pickers = {
        find_files = {
          find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
        },
      },
    },
  },
  config = function(_, opts)
    local telescope = require("telescope")
    telescope.setup(opts)
    pcall(telescope.load_extension, "fzf")
  end,
}
