local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	"folke/tokyonight.nvim",
	"tpope/vim-fugitive",
	"theprimeagen/harpoon",
	"mbbill/undotree",
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	},
	{
		"nvim-lualine/lualine.nvim",
		tag = "compat-nvim-0.6",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{
		"stevearc/dressing.nvim",
		tag = "v2.2.0",
		opts = {},
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		tag = "v3.5.4",
		main = "ibl",
		opts = {},
	},
	{
		"echasnovski/mini.indentscope",
		tag = "v0.12.0",
	},
	{ "MunifTanjim/nui.nvim", tag = "0.3.0" },
	{ "rcarriga/nvim-notify", tag = "v3.13.4" },
	{
		"folke/noice.nvim",
		tag = "v2.0.1",
		event = "VeryLazy",
		opts = {},
		dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
	},
	{
		"folke/which-key.nvim",
		tag = "v1.6.0",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {},
	},
	{ "kdheepak/lazygit.nvim", version = "0ada6c6e7e138df92f5009b6952f4ac41248305a" },
	-- START LSP RELATED PLUGINS --
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },
	{ "VonHeikemen/lsp-zero.nvim", branch = "v3.x" },
	{ "neovim/nvim-lspconfig" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/nvim-cmp" },
	{ "L3MON4D3/LuaSnip" },
	-- START AUTO-FORMATTING PLUGINS--
	{ "lukas-reineke/lsp-format.nvim", tag = "v2.6.5" },
	{
		"creativenull/efmls-configs-nvim",
		tag = "v1.6.0",
		dependencies = {
			"lukas-reineke/lsp-format.nvim",
			"neovim/nvim-lspconfig",
		},
	},
	{
		"nvimtools/none-ls.nvim",
		version = "88821b67e6007041f43b802f58e3d9fa9bfce684",
	},
	{
		"jay-babu/mason-null-ls.nvim",
		tag = "v2.6.0",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"nvimtools/none-ls.nvim",
		},
	},
	-- END AUTO-FORMATTING PLUGINS--
	-- END LSP RELATED PLUGINS --
	"github/copilot.vim",
	-- START DAP RELATED PLUGINS --
	"mfussenegger/nvim-dap",
	tag = "0.7.0",
	{
		"stevearc/overseer.nvim",
		tag = "v1.3.1",
		opts = {},
	},
	{
		"microsoft/vscode-js-debug",
		tag = "v1.88.0",
		build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
	},
	{
		"mxsdev/nvim-dap-vscode-js",
		tag = "v1.1.0",
		dependencies = { "mfussenegger/nvim-dap", "microsoft/vscode-js-debug", "stevearc/overseer.nvim" },
	},
	{
		"rcarriga/nvim-dap-ui",
		tag = "v4.0.0",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
	},
	-- END DAP RELATED PLUGINS --
})
