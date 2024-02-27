vim.g.mapleader = ' '

vim.keymap.set('i', 'jk', '<ESC>')
vim.keymap.set('n', '<Leader>w', ':write<CR>')
vim.keymap.set('n', '-', vim.cmd.Ex)
vim.keymap.set('n', '+', vim.cmd.Vex)
