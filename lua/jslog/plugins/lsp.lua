local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
end)

require('mason').setup({})
require('mason-lspconfig').setup({
  -- Requirements defined at https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
  ensure_installed = {'tsserver', 'eslint', 'lua_ls', 'efm'},
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


-- TODO: Should I be using null-ls instead:
-- https://github.com/jose-elias-alvarez/null-ls.nvim/discussions/244

-- Register linters and formatters per language
local prettier = require('efmls-configs.formatters.prettier')
--local stylua = require('efmls-configs.formatters.stylua')
local languages = {
  typescript = { prettier },
  typescriptreact = { prettier },
  --lua = { stylua },
}

-- Or use the defaults provided by this plugin
-- check doc/SUPPORTED_LIST.md for the supported languages
--
-- local languages = require('efmls-configs.defaults').languages()

local efmls_config = {
  filetypes = vim.tbl_keys(languages),
  settings = {
    rootMarkers = { '.git/' },
    languages = languages,
  },
  init_options = {
    documentFormatting = true,
    documentRangeFormatting = true,
  },
}

require("lsp-format").setup {}
require('lspconfig').efm.setup(vim.tbl_extend('force', efmls_config, {
  -- Pass your custom lsp config below like on_attach and capabilities
  --
  on_attach = require("lsp-format").on_attach
}))
