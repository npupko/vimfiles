local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- Languages
  use {
    'evanleck/vim-svelte',
    ft = { 'svelte' },
    config = function() require('plugins.vim-svelte') end
  }

  use {
    'leafoftree/vim-svelte-plugin',
    ft = { 'svelte' },
    config = function() require('plugins.vim-svelte-plugin') end
  }

  use { 'dstein64/vim-startuptime' }

  use { 'vim-crystal/vim-crystal', ft = { 'cr' } }
  use { 'ianks/vim-tsx', ft = { 'tsx' } }

  use {
    'MaxMEllon/vim-jsx-pretty',
    ft = { 'jsx' },
    config = function() require('plugins.vim-jsx-pretty') end
  }

  use { 'leafgarland/typescript-vim', ft = { 'ts' } }
  use { 'wavded/vim-stylus', ft = { 'stylus' } }
  use { 'keith/rspec.vim', ft = { 'rb' } }
  use { 'yuezk/vim-js' }

  -- Colorschemes
  use 'jacoborus/tender.vim'
  use { "ellisonleao/gruvbox.nvim" }

  -- Plugins
  -- use {
  --   'kyazdani42/nvim-tree.lua',
  --   requires = {
  --     'kyazdani42/nvim-web-devicons', -- optional, for file icon
  --   },
  --   config = function() require('plugins.nvim-tree') end
  -- }

  use {
    'ms-jpq/chadtree',
    branch = 'chad',
    run = ':CHADdeps',
    config = function() require('plugins.chadtree') end
  }

  use {
    'neovim/nvim-lspconfig',
    config = function() require('plugins.lspconfig') end
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function() require('plugins.nvim-treesitter') end
  }

  use {
    'Shougo/context_filetype.vim',
    config = function() require('plugins.context_filetype') end
  }

  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function() require('plugins.indent-blankline') end
  }

  use '/usr/local/opt/fzf'
  use 'junegunn/fzf.vim'

  use {
    'vim-ruby/vim-ruby',
    config = function() require('plugins.vim-ruby') end
  }

  use 'tpope/vim-rails'
  use 'tpope/vim-surround'

  use {
    'numToStr/Comment.nvim',
    config = function() require('Comment').setup() end
  }

  use 'tpope/vim-repeat'
  use 'tpope/vim-fugitive'
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
    config = function() require('plugins.vim-test') end
  }

  use 'AndrewRadev/splitjoin.vim'

  use {
    'ms-jpq/coq_nvim',
    config = function() require('plugins.coq_nvim') end
  }
  use { 'ms-jpq/coq.artifacts', branch = 'artifacts' }

  if packer_bootstrap then
    require('packer').sync()
  end
end)

