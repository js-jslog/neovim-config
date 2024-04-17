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

vim.keymap.set('n', '<Leader>lt', ':lua vim.lsp.buf.hover()<CR>')
vim.keymap.set('n', '<Leader>li', ':lua vim.lsp.buf.implementation()<CR>')
vim.keymap.set('n', '<Leader>ld', ':lua vim.lsp.buf.definition()<CR>')
vim.keymap.set('n', '<Leader>lci', ':lua vim.lsp.buf.incoming_calls()<CR>')
vim.keymap.set('n', '<Leader>lco', ':lua vim.lsp.buf.outgoing_calls()<CR>')
vim.keymap.set('n', '<Leader>lr', ':lua vim.lsp.buf.references()<CR>')
vim.keymap.set('n', '<Leader>r', ':lua vim.lsp.buf.rename()<CR>')
