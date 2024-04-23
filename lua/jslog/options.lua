vim.cmd([[colorscheme tokyonight]])

vim.opt.diffopt:append("vertical")

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

vim.opt.colorcolumn = "50,80,100"
vim.opt.cursorcolumn = true

vim.opt.updatetime = 50

-- Custom clipboard for sharing with host from container context
local isDevContainer = os.getenv("ISDEVCONTAINER")
if isDevContainer == "true" then
	-- The following clipboard is for use with an editor
	-- running in a container and coupled with a strategy
	-- which uses the $CLIPBOARDPATH as a system clipboard
	-- and the $CLIPEMITTERPATH as an application for
	-- getting the system clipboard contents out to the host.
	-- This config is agnostic about the location and
	-- implementation of these elements, other than the
	-- manner of input for $CLIPEMMITERPATH.

	local clipboard_path = os.getenv("CLIPBOARDPATH") or ""
	local clip_emitter_path = os.getenv("CLIPEMITTERPATH") or ""

	local function WriteToClipboard(clipcontents)
		local clipboard_file = io.open(clipboard_path, "w")
		if clipboard_file then
			for index, clipline in pairs(clipcontents) do
				if index > 1 then
					clipboard_file:write("\n")
				end
				clipboard_file:write(clipline)
			end
			clipboard_file:close()
		else
			print("Error: unable to open " .. clipboard_path .. " for writing.")
		end
	end

	local function EmitClipboard()
		vim.fn.system(clip_emitter_path)

		if vim.v.shell_error == 0 then
			print("Clipboard emitted successfully")
		else
			print("Error: Clipboard not emitted")
		end
	end

	vim.g.clipboard = {
		name = "container-compatible-clipboard",
		copy = {
			["+"] = function(clipcontents)
				WriteToClipboard(clipcontents)
				EmitClipboard()
			end,
			["*"] = function(clipcontents)
				WriteToClipboard(clipcontents)
				EmitClipboard()
			end,
		},
		paste = {
			["+"] = "cat " .. clipboard_path,
			["*"] = "cat " .. clipboard_path,
		},
		cache_enabled = 1,
	}
end
