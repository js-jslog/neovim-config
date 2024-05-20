-- This is apparently helpful to neotest, but I
-- can't see any improvement at the moment. I'm
-- also a little worried about potential conflicts
-- with anything lua related that Mason will do,
-- so I'd rather comment it out for now.
--require("neodev").setup({
--  library = { plugins = { "neotest" }, types = true },
--})

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
vim.keymap.set('n', '<Leader>ta', ':lua require"neotest".run.run(vim.fn.expand("%"))<CR>')
vim.keymap.set('n', '<Leader>td', ':lua require"neotest".run.run({strategy = "dap"})<CR>')
vim.keymap.set('n', '<Leader>ts', ':lua require"neotest".run.stop()<CR>')
