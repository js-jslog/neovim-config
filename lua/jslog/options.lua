vim.cmd[[colorscheme tokyonight]]

vim.opt.diffopt:append('vertical')

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

vim.opt.colorcolumn = '50,80,100'
vim.opt.cursorcolumn = true

vim.opt.updatetime = 50

-- The following clipboard is for use with an editor
-- running in a container and coupled with a strategy
-- which uses the /dev/clipboard as an intermediary.
-- This config specifically relies on a socat emitter
-- to get the clipboard contents out to the host,
-- but is agnostic about how the host is getting
-- it's clipboard content in to the container.
local function WriteToClipboard(clipcontents)
    local clipboard_file = io.open('/dev/clipboard', 'w')
    if clipboard_file then
        for index, clipline in pairs(clipcontents) do
            if index > 1 then
                clipboard_file:write('\n')
            end
            clipboard_file:write(clipline)
        end
        clipboard_file:close()
    else
        print('Error: unable to open /dev/clipboard for writing.')
    end
end

local function EmitClipboard()
    local script_path = '/development-env/socat-emitter-container.sh'
    local command = 'sh ' .. script_path

    vim.fn.system(command)

    if vim.v.shell_error == 0 then
        print('Clipboard emitted successfully')
    else
        print('Error: Clipboard not emitted')
    end
end

vim.g.clipboard = {
    name = 'container-compatible-clipboard',
    copy = {
        ['+'] = function(clipcontents)
            WriteToClipboard(clipcontents)
            EmitClipboard()
        end,
        ['*'] = function(clipcontents)
            WriteToClipboard(clipcontents)
            EmitClipboard()
        end,
    },
    paste = {
        ['+'] = 'cat /dev/clipboard',
        ['*'] = 'cat /dev/clipboard',
    },
    cache_enabled = 1
}
