require('mason').setup({
  log_level = vim.log.levels.DEBUG
})
require('mason-nvim-dap').setup({
  ensure_installed = { 'js', 'node2', 'chrome', 'firefox' },
})

vim.keymap.set('n', '<Leader>db', ':lua require"dap".toggle_breakpoint()<CR>')
vim.keymap.set('n', '<Leader>dc', ':lua require"dap".continue()<CR>')

local dap = require('dap')

dap.adapters['pwa-node'] = {
  type = "server",
  host = "localhost",
  port = "${port}",
  executable = {
    command = "node",
    args = {vim.fn.resolve(vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js"), "${port}"},
  }
}
dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = {vim.fn.resolve(vim.fn.stdpath("data") .. "/mason/packages/node-debug2-adapter/out/src/nodeDebug.js")},
}

dap.configurations.typescript = {
  {
		name = 'Node2: Launch';
		type = 'node2';
		request = 'launch';
		program = '${file}';
		cwd = vim.fn.getcwd();
		sourceMaps = true;
		protocol = 'inspector';
		console = 'integratedTerminal';
  },
  {
    type = "pwa-node",
    request = "launch",
    name = "Launch file",
    program = "${file}",
    cwd = "${workspaceFolder}",
		sourceMaps = true,
  },
  {
    type = "pwa-node",
    request = "attach",
    name = "Attach",
    processId = require'dap.utils'.pick_process,
    cwd = "${workspaceFolder}",
		sourceMaps = true,
  }
}

