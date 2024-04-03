local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  'folke/tokyonight.nvim',
  'tpope/vim-fugitive',
  'theprimeagen/harpoon',
  'mbbill/undotree',
  {
	  'nvim-telescope/telescope.nvim', tag = '0.1.5',
	  dependencies = { 'nvim-lua/plenary.nvim' }
  },
  {
	  'nvim-treesitter/nvim-treesitter',
	  run = ':TSUpdate'
  },
  -- START LSP RELATED PLUGINS --
  {'williamboman/mason.nvim'},
  {'williamboman/mason-lspconfig.nvim'},
  {'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
  {'neovim/nvim-lspconfig'},
  {'hrsh7th/cmp-nvim-lsp'},
  {'hrsh7th/nvim-cmp'},
  {'L3MON4D3/LuaSnip'},
  -- END LSP RELATED PLUGINS --
  'github/copilot.vim',
  'github/copilot.vim',
  {
    'rcarriga/nvim-dap-ui',
    dependencies = {'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio'}
  },
  {
    'jay-babu/mason-nvim-dap.nvim',
    dependencies = {'rcarriga/nvim-dap-ui','williamboman/mason.nvim'}
  }
})
