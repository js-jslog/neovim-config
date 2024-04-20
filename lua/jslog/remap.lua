vim.g.mapleader = ' '

vim.keymap.set('i', 'jk', '<ESC>')
vim.keymap.set('n', '<Leader>w', ':write<CR>')
vim.keymap.set('n', '<Leader>q', ':quit<CR>')
vim.keymap.set('n', '<Leader>wq', ':write<CR>:quit<CR>')
vim.keymap.set('n', '-', vim.cmd.Ex)
vim.keymap.set('n', '_', vim.cmd.Sex)
vim.keymap.set('n', '+', vim.cmd.Vex)

vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')
vim.keymap.set("n", "<Right>", ":vertical resize +5<CR>", { silent = true })
vim.keymap.set("n", "<Left>", ":vertical resize -5<CR>", { silent = true })
vim.keymap.set("n", "<Up>", ":resize +5<CR>", { silent = true })
vim.keymap.set("n", "<Down>", ":resize -5<CR>", { silent = true })

vim.keymap.set('n', ']q', ':cnext<CR>')
vim.keymap.set('n', '[q', ':cprev<CR>')

vim.api.nvim_set_keymap('n', '<Leader>gp', ":execute ':!git push'<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>gl', ":execute ':!git pull'<CR>", { noremap = true, silent = true })

-- Allow J & K to move visually selected blocks
vim.keymap.set('v', 'J', ':m \'>+1<CR>gv=gv')
vim.keymap.set('v', 'K', ':m \'<-2<CR>gv=gv')

-- Prevent cursor moving to end of line when using J
vim.keymap.set('n', 'J', 'mzJ`z')

-- Keep cursor in the middle of the screen when doing half page jumps
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- Keep cursor in the middle of screen if search result is off screen
-- This means we know where to find the search result when the whole
-- other context of the screen has changed. Less disorientating.
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- Paste without putting replaced text in to clipboard
-- Means you don't lose your clipboard if you paste over something to replace it
vim.keymap.set('x', '<Leader>p', '"_dP')

-- Allow copy / paste using the system clipboard
vim.keymap.set('n', '<Leader>y', '"+y')
vim.keymap.set('n', '<Leader>Y', '"+Y')
vim.keymap.set('v', '<Leader>y', '"+y')
vim.keymap.set('n', '<Leader>p', '"+p')
vim.keymap.set('n', '<Leader>P', '"+P')
vim.keymap.set('v', '<Leader>p', '"+p')

-- Allow deletion to the void
vim.keymap.set('n', '<Leader>d', '"_d')
vim.keymap.set('n', '<Leader>D', '"_D')
vim.keymap.set('v', '<Leader>d', '"_d')

-- Replace all occurences in file
vim.keymap.set('n','<Leader>s', ':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>')

-- Ensure that source is shown
-- (Doesn't seem to be working in float,
-- but I'll leave that config here anyway)
vim.diagnostic.config({
  virtual_text = { source = true },
  float = { source = true },
})
-- Hide all inline diagnostics messages (might be helpful if it's noisy)
vim.keymap.set('n', '<Leader>dih', ':lua vim.diagnostic.hide()<CR>')
-- Show all inline diagnostics messages
vim.keymap.set('n', '<Leader>dis', ':lua vim.diagnostic.show()<CR>')
-- Show this buffers diagnostics in a panel
vim.keymap.set('n', '<Leader>dip', ':lua vim.diagnostic.setloclist()<CR>')

-- Show currently marked files - see ShowNetrwMF for details
vim.keymap.set('n', '<Leader>mp', ':lua ShowNetrwMF()<CR>')

-- Copy currently marked files to the netrw target directory - see ShowNetrwMF for details
vim.keymap.set('n', '<Leader>mc', ':lua CopyNetrwMF()<CR>')
