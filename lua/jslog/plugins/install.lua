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
  -- START DAP RELATED PLUGINS --
  'mfussenegger/nvim-dap', tag = '0.7.0',
  {
    'stevearc/overseer.nvim', tag = 'v1.3.1',
    opts = {},
  },
  {
    'microsoft/vscode-js-debug', tag = 'v1.88.0',
    build = 'npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out'
  },
  {
    'mxsdev/nvim-dap-vscode-js', tag = 'v1.1.0',
    dependencies = {'mfussenegger/nvim-dap', 'microsoft/vscode-js-debug', 'stevearc/overseer.nvim' }
  },
  {
    'rcarriga/nvim-dap-ui', tag = 'v4.0.0',
    dependencies = {'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio'}
  },
  -- END DAP RELATED PLUGINS --
})
