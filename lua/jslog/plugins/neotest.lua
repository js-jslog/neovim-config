require('neotest').setup({
  adapters = {
    require('neotest-vitest') {
      filter_dir = function(name, rel_path, root)
        return name ~= 'node_modules'
      end,
    },
    -- JUST THE DEFAULT
    -- UPDATE WHEN ACTUALLY IN USE
    require('neotest-jest')({
      jestCommand = 'npm test --',
      jestConfigFile = 'custom.jest.config.ts',
      env = { CI = true },
      cwd = function(path)
        return vim.fn.getcwd()
      end,
    }),
    -- JUST THE DEFAULT
    -- UPDATE WHEN ACTUALLY IN USE
    -- THERE SEEMS TO BE A LOT OF CONFIG
    -- TO SET UP IN THE DOCS ACTUALLY
    -- https://github.com/nvim-neotest/neotest-go
    require('neotest-go'),
  },
})

vim.keymap.set('n', '<Leader>tt', ':lua require"neotest".run.run()<CR>')
vim.keymap.set('n', '<Leader>tf', ':lua require"neotest".run.run(vim.fn.expand("%"))<CR>')
vim.keymap.set('n', '<Leader>td', ':lua require"neotest".run.run({strategy = "dap"})<CR>')
vim.keymap.set('n', '<Leader>ts', ':lua require"neotest".run.stop()<CR>')
vim.keymap.set('n', '<Leader>ta', ':lua require"neotest".run.attach()<CR>')
