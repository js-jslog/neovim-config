require('mason').setup({
  log_level = vim.log.levels.DEBUG
})
require('mason-nvim-dap').setup({
  ensure_installed = { 'js', 'node2', 'chrome', 'firefox' },
})
require("dap-vscode-js").setup({
  -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
  -- debugger_path = vim.fn.resolve(vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js"),
  debugger_path = vim.fn.resolve(vim.fn.stdpath("data") .. "/lazy/vscode-js-debug/"), -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
  -- debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
  -- debugger_cmd = { vim.fn.resolve(vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js") }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
  adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost', 'chrome' }, -- which adapters to register in nvim-dap
  -- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
  -- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
  -- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
})
require("dapui").setup()

local js_based_languages = { "typescript", "javascript", "typescriptreact", "javascriptreact" };
for _, language in ipairs(js_based_languages) do
  require("dap").configurations[language] = {
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
      --processId = require'dap.utils'.pick_process, -- seems not to be required, auto-attach happens successfully in all the contexts I've tried
      cwd = "${workspaceFolder}",
      --cwd = vim.fn.getcwd(), -- alternate way of getting workspace folder which may only do the same as "${workspaceFolder}" but while I'm paranoid about getting this working I jjj
      port = 9230,
      sourceMaps = true,
    },
    -- Divider for the launch.json derived configs
    {
      name = '----- launch.json configs (if available) -----',
      type = '',
      request = 'launch',
    },
  }
end
local dap_vscode = require('dap.ext.vscode')
dap_vscode.json_decode = require('overseer.json').decode
dap_vscode.load_launchjs(nil, {
  ['chrome'] = js_based_languages,
  ['node'] = js_based_languages,
  ['pwa-node'] = js_based_languages,
  ['pwa-chrome'] = js_based_languages,
  ['node-terminal'] = js_based_languages,
})

vim.keymap.set('n', '<Leader>db', ':lua require"dap".toggle_breakpoint()<CR>')
vim.keymap.set('n', '<Leader>dc', ':lua require"dap".continue()<CR>')
vim.keymap.set('n', '<Leader>do', ':lua require"dap".step_over()<CR>')
vim.keymap.set('n', '<Leader>di', ':lua require"dap".step_into()<CR>')
vim.keymap.set('n', '<Leader>dr', ':lua require"dap".repl.open()<CR>')

local dap, dapui = require("dap"), require("dapui")
dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end
