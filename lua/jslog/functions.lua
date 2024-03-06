-- Copy the netrw marked files to the netrw target directory
-- This replaces the default netrw mc command which fails in windows
-- This function is not perfect because it does not unmark the files
-- afterwards. It's worth running `mu` straight after running this.
function CopyNetrwMF()
    local marked_files = vim.fn['netrw#Expose']('netrwmarkfilelist')
    local destination = vim.fn['netrw#Expose']('netrwmftgt')

    if destination == 'n/a' then
        print('No destination set')
        return
    end

    for index, file in pairs(marked_files) do
        vim.cmd('!xcopy ' .. file:gsub("/", "\\") .. ' ' .. destination:gsub("/", "\\") .. '\\.')
    end
end
-- Helper function to show what CopyNetrwMF is going to
-- be copying, in case there are more files then you expect
-- already marked. Run `mu` and remark if this is the case.
function ShowNetrwMF()
    local marked_files = vim.fn['netrw#Expose']('netrwmarkfilelist')

    for index, file in pairs(marked_files) do
        print(index, file)
    end
end

