vim.g.mapleader = ' '

vim.keymap.set('i', 'jk', '<ESC>')
vim.keymap.set('n', '<Leader>w', ':write<CR>')
vim.keymap.set('n', '-', vim.cmd.Ex)
vim.keymap.set('n', '+', vim.cmd.Vex)

vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')
vim.keymap.set("n", "<Right>", ":vertical resize +5<CR>", { silent = true })
vim.keymap.set("n", "<Left>", ":vertical resize -5<CR>", { silent = true })
vim.keymap.set("n", "<Up>", ":resize +5<CR>", { silent = true })
vim.keymap.set("n", "<Up>", ":resize -5<CR>", { silent = true })

vim.api.nvim_set_keymap('n', '<Leader>gp', ":execute ':!git push'<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>gl', ":execute ':!git pull'<CR>", { noremap = true, silent = true })

vim.api.nvim_set_option("clipboard", "unnamed")
