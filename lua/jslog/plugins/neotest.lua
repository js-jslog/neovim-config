-- This is apparently helpful to neotest, but I
-- can't see any improvement at the moment. I'm
-- also a little worried about potential conflicts
-- with anything lua related that Mason will do,
-- so I'd rather comment it out for now.
-- require("neodev").setup({
-- 	library = { plugins = { "neotest" }, types = true },
-- })

require("neotest").setup({
	adapters = {
		require("neotest-vitest")({
			filter_dir = function(name, rel_path, root)
				return name ~= "node_modules"
			end,
		}),
		-- JUST THE DEFAULT
		-- UPDATE WHEN ACTUALLY IN USE
		require("neotest-jest")({
			jestCommand = "npm test --",
			env = { CI = true },
			cwd = function(path)
				-- Find the nearest package directory by
				-- looking for package.json starting from
				-- the test file and walking up
				local current_dir = vim.fn.fnamemodify(path, ":h")

				while current_dir ~= "/" do
					local package_json = current_dir .. "/package.json"

					-- Check if both package.json exists
					if vim.fn.filereadable(package_json) == 1 then
						return current_dir
					end

					-- Move up one directory
					current_dir = vim.fn.fnamemodify(current_dir, ":h")
				end

				-- Fallback to current working directory if not found
				return vim.fn.getcwd()
			end,
		}),
	},
})

vim.keymap.set("n", "<Leader>tt", ':lua require"neotest".run.run()<CR>')
vim.keymap.set("n", "<Leader>ta", ':lua require"neotest".run.run(vim.fn.expand("%"))<CR>')
vim.keymap.set("n", "<Leader>td", ':lua require"neotest".run.run({strategy = "dap"})<CR>')
vim.keymap.set("n", "<Leader>ts", ':lua require"neotest".run.stop()<CR>')
