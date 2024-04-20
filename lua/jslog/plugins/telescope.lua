local telescope = require('telescope')
telescope.setup({
  defaults = {
    file_ignore_patterns = { '.git/.*', 'node_modules/.*', 'package.lock.json' },
  },
  pickers = {
    find_files = { hidden = true },
    live_grep = {
      additional_args = {'--hidden'}
    },
    grep_string = {
      additional_args = {'--hidden'}
    },
  }
})
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fl', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fg', builtin.grep_string, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fs', builtin.git_status, {})
vim.keymap.set('n', '<leader>fd', builtin.diagnostics, {})

vim.keymap.set('n', '<leader>faf', function ()
  local opts = { file_ignore_patterns = {} }
  builtin.find_files(opts)
end, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>fag', function ()
  local opts = { file_ignore_patterns = {} }
  builtin.live_grep(opts)
end, { noremap = true, silent = true })
