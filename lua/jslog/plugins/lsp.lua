local lsp_zero = require("lsp-zero")

lsp_zero.on_attach(function(client, bufnr)
	-- see :help lsp-zero-keybindings
	-- to learn the available actions
	lsp_zero.default_keymaps({ buffer = bufnr })
	------- WARNING ------- WARNING ------- WARNING -------
	-- Included to allow `Trouble workspace_diagnostics`
	-- to show results for non-buffered files.
	-- The autor warns that this might come with some risk
	-- so I should keep my eyes open.
	require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)
	--END-- WARNING ------- WARNING ------- WARNING -------
end)

require("mason").setup({})
require("mason-lspconfig").setup({
	-- Requirements defined at https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
	ensure_installed = { "ts_ls", "eslint", "lua_ls" },
	handlers = {
		lsp_zero.default_setup,
		-- In a monorepo (no root tsconfig.json), the
		-- default root_pattern finds the workspace
		-- package.json first, which has no tsconfig.
		-- So we aim for the closest parent dir with
		-- a tsconfig.json instead.
		ts_ls = function()
			require("lspconfig").ts_ls.setup({
				root_dir = require("lspconfig.util").root_pattern("tsconfig.json", ".git"),
			})
		end,
	},
})

local cmp = require("cmp")
cmp.setup({
	mapping = {
		["<Tab>"] = cmp.mapping.select_next_item(),
		["<S-Tab>"] = cmp.mapping.select_prev_item(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<C-j>"] = cmp.mapping.select_next_item(),
		["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-l>"] = cmp.mapping.confirm({ select = true }),
	},
})

vim.keymap.set("n", "<Leader>lt", ":lua vim.lsp.buf.hover()<CR>")
vim.keymap.set("n", "<Leader>li", ":lua vim.lsp.buf.implementation()<CR>")
vim.keymap.set("n", "<Leader>ld", ":lua vim.lsp.buf.definition()<CR>")
vim.keymap.set("n", "<Leader>lci", ":lua vim.lsp.buf.incoming_calls()<CR>")
vim.keymap.set("n", "<Leader>lco", ":lua vim.lsp.buf.outgoing_calls()<CR>")
vim.keymap.set("n", "<Leader>lr", ":lua vim.lsp.buf.references()<CR>")
vim.keymap.set("n", "<Leader>r", ":lua vim.lsp.buf.rename()<CR>")
vim.keymap.set("n", "<Leader>lca", ":lua vim.lsp.buf.code_action()<CR>")
vim.keymap.set("n", "<leader>xa", ':lua require"trouble".toggle("workspace_diagnostics")<CR>')
vim.keymap.set("n", "<leader>xb", ':lua require"trouble".toggle("document_diagnostics")<CR>')

local null_ls = require("null-ls")
null_ls.setup()

-- TODO: If I want to upgrade to prettierd in the future
-- then I might have to find a way to set this variable
--os.execute("export PRETTIERD_DEFAULT_CONFIG=/app/.prettierrc")
require("mason-null-ls").setup({
	ensure_installed = { "prettier", "stylua" },
	handlers = {
		function() end, -- disables automatic setup of all null-ls sources
		---@diagnostic disable-next-line: unused-local
		prettier = function(source_name, methods)
			null_ls.register(null_ls.builtins.formatting.prettier)
		end,
		---@diagnostic disable-next-line: unused-local
		stylua = function(source_name, methods)
			null_ls.register(null_ls.builtins.formatting.stylua)
		end,
	},
})
vim.cmd("autocmd BufWritePre * lua vim.lsp.buf.format()")
