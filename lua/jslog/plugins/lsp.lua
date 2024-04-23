local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
end)

require('mason').setup({})
require('mason-lspconfig').setup({
  -- Requirements defined at https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
  ensure_installed = {'tsserver', 'eslint', 'lua_ls'},
  handlers = {
    lsp_zero.default_setup,
  },
})

vim.keymap.set('n', '<Leader>t', ':lua vim.lsp.buf.hover()<CR>')
vim.keymap.set('n', '<Leader>li', ':lua vim.lsp.buf.implementation()<CR>')
vim.keymap.set('n', '<Leader>ld', ':lua vim.lsp.buf.definition()<CR>')
vim.keymap.set('n', '<Leader>lci', ':lua vim.lsp.buf.incoming_calls()<CR>')
vim.keymap.set('n', '<Leader>lco', ':lua vim.lsp.buf.outgoing_calls()<CR>')
vim.keymap.set('n', '<Leader>lr', ':lua vim.lsp.buf.references()<CR>')
vim.keymap.set('n', '<Leader>r', ':lua vim.lsp.buf.rename()<CR>')


local null_ls = require 'null-ls'
null_ls.setup()

-- TODO: If I want to upgrade to prettierd in the future
-- then I might have to find a way to set this variable
--os.execute("export PRETTIERD_DEFAULT_CONFIG=/app/.prettierrc")
require('mason-null-ls').setup({
  ensure_installed = { 'prettier' },
  handlers = {
    function() end, -- disables automatic setup of all null-ls sources
    ---@diagnostic disable-next-line: unused-local
    prettier = function(source_name, methods)
      null_ls.register(null_ls.builtins.formatting.prettier)
    end,
  },
})
vim.cmd("autocmd BufWritePre * lua vim.lsp.buf.format()")
