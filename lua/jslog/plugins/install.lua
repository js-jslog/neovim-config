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

-- Define version numbers as local variables for those plugins
-- which are dependencies of multiple other plugins. This will
-- help maintain consistency and avoid misaligned dependencies
local nvimNioTag = "v1.9.0"
local plenaryTag = "v0.1.4"
local nvimWebDeviconsTag = "v0.100"
local masonTag = "v1.10.0"
local nvimDapTag = "0.7.0"
local nvimTreesitterTag = "v0.9.2"

require("lazy").setup({
	----------------------------------------
	--....................................--
	--........ START LSP PLUGINS .........--
	--....................................--
	----------------------------------------
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		-- commit = "f12d50716e8e59ea9f5cf484eac6968c33a95917" TODO: replace previous line with this when ready
		dependencies = {
			{
				"williamboman/mason-lspconfig.nvim",
				tag = "v1.29.0",
				dependencies = {
					{ "williamboman/mason.nvim", tag = masonTag },
				},
			},
			{ "neovim/nvim-lspconfig", tag = "v0.1.7" },
			{ "hrsh7th/cmp-nvim-lsp", commit = "39e2eda76828d88b773cc27a3f61d2ad782c922d" },
			{ "hrsh7th/nvim-cmp", commit = "5260e5e8ecadaf13e6b82cf867a909f54e15fd07" },
			{ "L3MON4D3/LuaSnip", tag = "v2.3.0" },
		},
	},
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
			{
				{ "williamboman/mason.nvim", tag = masonTag },
			},
			{ "nvimtools/none-ls.nvim", commit = "88821b67e6007041f43b802f58e3d9fa9bfce684" },
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
		"mxsdev/nvim-dap-vscode-js",
		tag = "v1.1.0",
		dependencies = {
			{
				"mfussenegger/nvim-dap",
				tag = nvimDapTag,
			},
			{
				"microsoft/vscode-js-debug",
				tag = "v1.88.0",
				build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
			},
			{
				"stevearc/overseer.nvim",
				tag = "v1.3.1",
				opts = {},
			},
		},
	},
	{
		"rcarriga/nvim-dap-ui",
		tag = "v4.0.0",
		dependencies = {
			{
				"mfussenegger/nvim-dap",
				tag = nvimDapTag,
			},
			{ "nvim-neotest/nvim-nio", tag = nvimNioTag },
		},
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
			{ "nvim-neotest/nvim-nio", tag = nvimNioTag },
			{ "nvim-lua/plenary.nvim", tag = plenaryTag },
			{
				"antoinemadec/FixCursorHold.nvim",
				commit = "1900f89dc17c603eec29960f57c00bd9ae696495",
			}, -- Claims not to be required at https://github.com/antoinemadec/FixCursorHold.nvim but it is. See https://github.com/antoinemadec/FixCursorHold.nvim/issues/13
			{
				"nvim-treesitter/nvim-treesitter",
				tag = nvimTreesitterTag,
			},
			-- the optional one
			-- { "folke/neodev.nvim", tag = "v2.5.2", opts = {} },
			-- then adapters
			{ "marilari88/neotest-vitest", tag = "v0.2.0" },
			{
				"nvim-neotest/neotest-jest",
				commit = "514fd4eae7da15fd409133086bb8e029b65ac43f",
			},
			{
				"nvim-neotest/neotest-go",
				commit = "6a2f996d89fe4631942e035b1c114544ee045043",
			},
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
		tag = nvimTreesitterTag,
		run = ":TSUpdate",
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = { "nvim-lua/plenary.nvim", tag = plenaryTag },
	},
	{ "theprimeagen/harpoon", commit = "ccae1b9bec717ae284906b0bf83d720e59d12b91" },
	{ "tpope/vim-fugitive", commit = "4f59455d2388e113bd510e85b310d15b9228ca0d" },
	{ "kdheepak/lazygit.nvim", commit = "0ada6c6e7e138df92f5009b6952f4ac41248305a" },
	{
		"folke/trouble.nvim",
		tag = "v2.10.0",
		dependencies = {
			{ "nvim-tree/nvim-web-devicons", tag = nvimWebDeviconsTag },
			{
				----------------------------------------
				--....................................--
				--..... WARNING ....... WARNING ......--
				--....................................--
				----------------------------------------
				-- Included to allow `Trouble workspace_diagnostics` to show results for non-buffered files.
				-- The autor warns that this might come with some risk so I should keep my eyes open.
				"artemave/workspace-diagnostics.nvim",
				commit = "429174d53652dbef56868a2cbeb8b28cb5d44fdd",
				----------------------------------------
				--....................................--
				--. END WARNING ... END WARNING ......--
				--....................................--
				----------------------------------------
			},
		},
	},
	{ "mbbill/undotree", commit = "56c684a805fe948936cda0d1b19505b84ad7e065" },
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
		dependencies = {
			{ "nvim-tree/nvim-web-devicons", tag = nvimWebDeviconsTag },
		},
	},
	{
		"folke/noice.nvim",
		tag = "v3.0.1",
		event = "VeryLazy",
		opts = {},
		dependencies = {
			{ "MunifTanjim/nui.nvim", tag = "0.3.0" },
			{ "rcarriga/nvim-notify", tag = "v3.13.4" },
		},
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
})
