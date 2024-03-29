local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  Packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

local config = {
  -- display = {
  --   open_fn = require('packer.util').float,
  -- }
}

return require('packer').startup({function(use)
  use 'wbthomason/packer.nvim'

  use {
    'kyazdani42/nvim-web-devicons',
    config = function() require("nvim-web-devicons").setup{ default = true } end,
  }

  use 'folke/neodev.nvim'

  -- -- Languages
  use 'fladson/vim-kitty'
  use { "kchmck/vim-coffee-script", ft = "coffee" }
  use { "terrastruct/d2-vim", ft = "d2" }

  -- use {
  --   'leafoftree/vim-svelte-plugin',
  --   ft = { 'svelte' },
  --   config = function() require('plugins.vim_svelte_plugin') end
  -- }
  --
  -- use {
  --   'evanleck/vim-svelte',
  --   ft = { 'svelte' },
  --   requires = {
  --     'othree/html5.vim',
  --     'pangloss/vim-javascript',
  --   },
  --   config = function() require('plugins.vim_svelte') end
  -- }

  use {
    'dstein64/vim-startuptime',
    opt = true,
    cmd = { 'StartupTime' },
  }

  -- use { 'leafgarland/typescript-vim', ft = { 'ts', 'svelte', 'js' } }
  -- use { 'keith/rspec.vim', ft = { 'rb' } }
  -- use { 'yuezk/vim-js' }

  -- Colorschemes
  -- use { 'jacoborus/tender.vim', opt = true }
  -- use { "ellisonleao/gruvbox.nvim", config = function() require('plugins.gruvbox') end }
  use { 'ellisonleao/gruvbox.nvim' }

  -- Plugins
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
    },
    config = function() require('plugins.nvim_tree') end
  }

  use "nvim-lua/plenary.nvim"

  use {
    "neovim/nvim-lspconfig",
    requires = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "jose-elias-alvarez/null-ls.nvim" 
    },
    config = function()
      require('plugins.mason')
    end
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function() require('plugins.nvim_treesitter') end
  }

  -- TODO: Don't use it yet
  -- use { 'nvim-treesitter/nvim-treesitter-textobjects' }
  use { 'JoosepAlviste/nvim-ts-context-commentstring' }

  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function() require('plugins.indent_blankline') end
  }

  -- use { 'junegunn/fzf', run = function() vim.fn['fzf#install']() end }
  -- use { 'junegunn/fzf.vim', config = function() require('plugins.fzf-vim') end }

  -- use {
  --   'ibhagwan/fzf-lua',
  --   requires = { 'kyazdani42/nvim-web-devicons' },
  --   config = function() require('plugins.fzf_lua') end
  -- }

  -- use {
  --   'nvim-telescope/telescope.nvim',
  --   requires = {
  --     'nvim-lua/plenary.nvim',
  --   },
  --   config = function() require('plugins.telescope') end
  -- }

  use { 'junegunn/fzf', run = function() vim.fn['fzf#install']() end }
  use { 'junegunn/fzf.vim', config = function() require('plugins.fzf-vim') end }

  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

  use {
    'vim-ruby/vim-ruby',
    config = function() require('plugins.vim_ruby') end
  }

  use  {
    'tpope/vim-rails',
    config = function() require('plugins.vim_rails') end
  }
  use 'tpope/vim-surround'
  use 'tpope/vim-dispatch'

  use {
    'numToStr/Comment.nvim',
    config = function() require('plugins.Comment') end
  }

  use 'tpope/vim-repeat'
  use {
    'tpope/vim-fugitive',
    config = function() require('plugins.vim_fugitive') end
  }
  use 'tpope/vim-endwise'
  use 'tpope/vim-unimpaired'
  use 'tpope/vim-rhubarb'

  use 'jparise/vim-graphql'

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function() require('plugins.lualine') end
  }

  use 'mattn/emmet-vim'

  use {
    'janko-m/vim-test',
    config = function() require('plugins.vim_test') end
  }

  use 'AndrewRadev/splitjoin.vim'

  use {
    'github/copilot.vim',
    config = function() require('plugins.copilot') end
  }

  use {
    'mattn/vim-gist',
    requires = { 'mattn/webapi-vim' },
  }

  -- use {
  --   'takac/vim-hardtime',
  --   config = function()
  --     vim.g.hardtime_default_on = 1
  --     vim.g.hardtime_motion_with_count_resets = 1
  --     vim.g.hardtime_allow_different_key = 1
  --     vim.g.hardtime_ignore_buffer_patterns = { "NvimTree.*", "help.*" }
  --   end
  -- }

  -- use { 'nvim-treesitter/playground' }

  -- cmp plugins
  use {
    "hrsh7th/nvim-cmp",
    config = function() require('plugins.cmp_lsp') end,
    -- commit = 'bba6fb67fdafc0af7c5454058dfbabc2182741f4'
  }
  use "onsails/lspkind.nvim"
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp"
  -- use {'tzachar/cmp-tabnine', run='./install.sh', requires = 'hrsh7th/nvim-cmp'}

  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  if Packer_bootstrap then
    require('packer').sync()
  end
end,
config = config
})

