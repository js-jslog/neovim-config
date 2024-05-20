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
	-----------------------------------------------------------
	--.......................................................--
	--.......................................................--
	--.......... START THE DEPENDENCY ONLY PLUGINS ..........--
	--.......... as far as I'm aware I don't think ..........--
	--.......... I use any of these directly       ..........--
	--.......................................................--
	--.......................................................--
	-----------------------------------------------------------
	{ "nvim-neotest/nvim-nio", tag = "v1.9.0" },
	{ "nvim-lua/plenary.nvim", tag = "v0.1.4" },
	{ "antoinemadec/FixCursorHold.nvim", version = "1900f89dc17c603eec29960f57c00bd9ae696495" }, -- Claims not to be required at https://github.com/antoinemadec/FixCursorHold.nvim but it is. See https://github.com/antoinemadec/FixCursorHold.nvim/issues/13
	{ "marilari88/neotest-vitest", tag = "v0.2.0" },
	{ "nvim-neotest/neotest-jest", version = "514fd4eae7da15fd409133086bb8e029b65ac43f" },
	{ "nvim-neotest/neotest-go", version = "6a2f996d89fe4631942e035b1c114544ee045043" },
	{ "folke/neodev.nvim", tag = "v2.5.2", opts = {} },
	{ "nvim-tree/nvim-web-devicons", tag = "v0.100" },
	{ "MunifTanjim/nui.nvim", tag = "0.3.0" },
	{ "rcarriga/nvim-notify", tag = "v3.13.4" },
	{ "williamboman/mason.nvim", tag = "v1.10.0" },
	{
		"nvimtools/none-ls.nvim",
		version = "88821b67e6007041f43b802f58e3d9fa9bfce684",
	},
	----------------------------------------
	--....................................--
	--..... WARNING ....... WARNING ......--
	--....................................--
	----------------------------------------
	-- Included to allow `Trouble workspace_diagnostics` to show results for non-buffered files.
	-- The autor warns that this might come with some risk so I should keep my eyes open.
	{ "artemave/workspace-diagnostics.nvim", version = "429174d53652dbef56868a2cbeb8b28cb5d44fdd" },
	----------------------------------------
	--....................................--
	--. END WARNING ... END WARNING ......--
	--....................................--
	----------------------------------------
	-----------------------------------------------------------
	--.......................................................--
	--.......................................................--
	--........... END THE DEPENDENCY ONLY PLUGINS ...........--
	--.......................................................--
	--.......................................................--
	-----------------------------------------------------------
	-----------------------------------------------------------
	--.......................................................--
	--.......................................................--
	--.............. START THE UTILITY PLUGINS ..............--
	--.......................................................--
	--.......................................................--
	-----------------------------------------------------------
	----------------------------------------
	--....................................--
	--........ START LSP PLUGINS .........--
	--....................................--
	----------------------------------------
	{
		"williamboman/mason-lspconfig.nvim",
		tag = "v1.29.0",
		dependencies = { "williamboman/mason.nvim" },
	},
	{ "VonHeikemen/lsp-zero.nvim", branch = "v3.x" },
	-- { "VonHeikemen/lsp-zero.nvim", version = "f12d50716e8e59ea9f5cf484eac6968c33a95917" }, TODO: replace previous line with this when ready
	{ "neovim/nvim-lspconfig", tag = "v0.1.7" },
	{ "hrsh7th/cmp-nvim-lsp", version = "39e2eda76828d88b773cc27a3f61d2ad782c922d" },
	{ "hrsh7th/nvim-cmp", version = "5260e5e8ecadaf13e6b82cf867a909f54e15fd07" },
	{ "L3MON4D3/LuaSnip", tag = "v2.3.0" },
	-----------------------------------
	--...............................--
	-- START AUTO-FORMATTING PLUGINS --
	--...............................--
	-----------------------------------
	{
		"jay-babu/mason-null-ls.nvim",
		tag = "v2.6.0",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"nvimtools/none-ls.nvim",
		},
	},
	-----------------------------------
	--...............................--
	--. END AUTO-FORMATTING PLUGINS .--
	--...............................--
	-----------------------------------
	----------------------------------------
	--....................................--
	--.......... END LSP PLUGINS .........--
	--....................................--
	----------------------------------------
	----------------------------------------
	--....................................--
	--......... START DAP PLUGINS ........--
	--....................................--
	----------------------------------------
	{
		"mfussenegger/nvim-dap",
		tag = "0.7.0",
	},
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
	----------------------------------------
	--....................................--
	--.......... END DAP PLUGINS .........--
	--....................................--
	----------------------------------------
	----------------------------------------
	--....................................--
	--........ START TEST PLUGINS ........--
	--....................................--
	----------------------------------------
	{
		"nvim-neotest/neotest",
		tag = "v5.1.0",
		dependencies = {
			-- first the required deps
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim", -- Claims not to be required at https://github.com/antoinemadec/FixCursorHold.nvim but it is. See https://github.com/antoinemadec/FixCursorHold.nvim/issues/13
			"nvim-treesitter/nvim-treesitter",
			-- the optional one
			-- "folke/neodev.nvim",
			-- then adapters
			"marilari88/neotest-vitest",
			"nvim-neotest/neotest-jest",
			"nvim-neotest/neotest-go",
		},
	},
	----------------------------------------
	--....................................--
	--......... END TEST PLUGINS .........--
	--....................................--
	----------------------------------------
	----------------------------------------
	--....................................--
	-- START OTHER KEY FUNCTIONAL PLUGINS --
	--....................................--
	----------------------------------------
	{
		"nvim-treesitter/nvim-treesitter",
		tag = "v0.9.2",
		run = ":TSUpdate",
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{ "theprimeagen/harpoon", version = "ccae1b9bec717ae284906b0bf83d720e59d12b91" },
	{ "tpope/vim-fugitive", version = "4f59455d2388e113bd510e85b310d15b9228ca0d" },
	{ "kdheepak/lazygit.nvim", version = "0ada6c6e7e138df92f5009b6952f4ac41248305a" },
	{
		"folke/trouble.nvim",
		tag = "v2.10.0",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"artemave/workspace-diagnostics.nvim",
		},
	},
	{ "mbbill/undotree", version = "56c684a805fe948936cda0d1b19505b84ad7e065" },
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
	----------------------------------------
	--....................................--
	--. END OTHER KEY FUNCTIONAL PLUGINS .--
	--....................................--
	----------------------------------------
	----------------------------------------
	--....................................--
	--....... START VISUAL PLUGINS .......--
	--....................................--
	----------------------------------------
	{ "folke/tokyonight.nvim", tag = "v3.0.1" },
	{
		"nvim-lualine/lualine.nvim",
		tag = "compat-nvim-0.6",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{
		"folke/noice.nvim",
		tag = "v2.0.1",
		event = "VeryLazy",
		opts = {},
		dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
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
	----------------------------------------
	--....................................--
	--........ END VISUAL PLUGINS ........--
	--....................................--
	----------------------------------------
	----------------------------------------
	--....................................--
	--....... START OTHER PLUGINS ........--
	--....................................--
	----------------------------------------
	{ "github/copilot.vim", branch = "release" },
	----------------------------------------
	--....................................--
	--........ END OTHER PLUGINS .........--
	--....................................--
	----------------------------------------
	-----------------------------------------------------------
	--.......................................................--
	--.......................................................--
	--............... END THE UTILITY PLUGINS ...............--
	--.......................................................--
	--.......................................................--
	-----------------------------------------------------------
})
