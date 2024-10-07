return {
  'ThePrimeagen/harpoon',
  enabled = true,
  branch = "harpoon2",
  dependencies = {
    'nvim-lua/plenary.nvim'
  },
  config = function()
    -- vim.keymap.set('n', '<leader>h', '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>', { noremap = true, silent = true })

    -- vim.keymap.set('n', '<leader>1', '<cmd>lua require("harpoon.ui").nav_file(1)<cr>', { noremap = true, silent = true })
    -- vim.keymap.set('n', '<leader>2', '<cmd>lua require("harpoon.ui").nav_file(2)<cr>', { noremap = true, silent = true })
    -- vim.keymap.set('n', '<leader>3', '<cmd>lua require("harpoon.ui").nav_file(3)<cr>', { noremap = true, silent = true })
    -- vim.keymap.set('n', '<leader>4', '<cmd>lua require("harpoon.ui").nav_file(4)<cr>', { noremap = true, silent = true })
    -- vim.keymap.set('n', '<leader>5', '<cmd>lua require("harpoon.ui").nav_file(5)<cr>', { noremap = true, silent = true })
    -- vim.keymap.set('n', '<leader>6', '<cmd>lua require("harpoon.ui").nav_file(6)<cr>', { noremap = true, silent = true })
    -- vim.keymap.set('n', '[h', '<cmd>lua require("harpoon.ui").nav_prev()<cr>', { noremap = true, silent = true })
    -- vim.keymap.set('n', ']h', '<cmd>lua require("harpoon.ui").nav_next()<cr>', { noremap = true, silent = true })

    -- local keymap = vim.keymap.set
    -- local ui = require('harpoon.ui')
    -- local mark = require('harpoon.mark')
    --
    -- keymap('n', '<leader>1', function() ui.nav_file(1) end, { noremap = true, silent = true })
    -- keymap('n', '<M-1>', function() ui.nav_file(1) end, { noremap = true, silent = true })
    -- keymap('n', '<leader>2', function() ui.nav_file(2) end, { noremap = true, silent = true })
    -- keymap('n', '<M-2>', function() ui.nav_file(2) end, { noremap = true, silent = true })
    -- keymap('n', '<leader>3', function() ui.nav_file(3) end, { noremap = true, silent = true })
    -- keymap('n', '<M-3>', function() ui.nav_file(3) end, { noremap = true, silent = true })
    -- keymap('n', '<leader>4', function() ui.nav_file(4) end, { noremap = true, silent = true })
    -- keymap('n', '<M-4>', function() ui.nav_file(4) end, { noremap = true, silent = true })
    -- keymap('n', '<leader>5', function() ui.nav_file(5) end, { noremap = true, silent = true })
    -- keymap('n', '<M-5>', function() ui.nav_file(5) end, { noremap = true, silent = true })
    -- keymap('n', '<leader>6', function() ui.nav_file(6) end, { noremap = true, silent = true })
    -- keymap('n', '<M-6>', function() ui.nav_file(6) end, { noremap = true, silent = true })
    --
    -- keymap('n', '[h', function() ui.nav_prev() end, { noremap = true, silent = true })
    -- keymap('n', ']h', function() ui.nav_next() end, { noremap = true, silent = true })
    --
    -- keymap('n', '<leader>a', function() mark.add_file() end, { noremap = true, silent = true })
    -- keymap('n',"<c-s>", function () ui.toggle_quick_menu() end, { noremap = true, silent = true })

    local harpoon = require("harpoon")

    harpoon:setup()

    vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
    vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

    vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
    vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)
    vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)
    vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end)

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set("n", "<leader>n", function() harpoon:list():prev() end)
    vim.keymap.set("n", "<leader>p", function() harpoon:list():next() end)

    -- -- basic telescope configuration
    -- local conf = require("telescope.config").values
    -- local function toggle_telescope(harpoon_files)
    --   local file_paths = {}
    --   for _, item in ipairs(harpoon_files.items) do
    --     table.insert(file_paths, item.value)
    --   end
    --
    --   require("telescope.pickers").new({}, {
    --     prompt_title = "Harpoon",
    --     finder = require("telescope.finders").new_table({
    --       results = file_paths,
    --     }),
    --     previewer = conf.file_previewer({}),
    --     sorter = conf.generic_sorter({}),
    --   }):find()
    -- end
    --
    -- vim.keymap.set("n", "<C-e>", function() toggle_telescope(harpoon:list()) end,
    --   { desc = "Open harpoon window" })
  end,
}
