vim.g.mapleader = ' '

vim.keymap.set('i', 'jk', '<ESC>')
vim.keymap.set('n', '<Leader>w', ':write<CR>')
vim.keymap.set('n', '-', vim.cmd.Ex)
vim.keymap.set('n', '+', vim.cmd.Vex)

vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')
