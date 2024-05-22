require("oil").setup({
	view_options = {
		show_hidden = true,
	},
})

vim.keymap.set("n", "-", "<CMD>Oil<CR>")
vim.keymap.set("n", "_", "<CMD>split<CR><CMD>Oil<CR>")
vim.keymap.set("n", "+", "<CMD>vsplit<CR><CMD>Oil<CR>")
