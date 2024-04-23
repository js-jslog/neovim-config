local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<Leader>a", mark.add_file)
vim.keymap.set("n", "<Leader>o", ui.toggle_quick_menu)
vim.keymap.set("n", "<C-p>", ui.nav_prev)
vim.keymap.set("n", "<C-n>", ui.nav_next)
