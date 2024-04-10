local highlight = {
    "RainbowRed",
}

local hooks = require "ibl.hooks"
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#444444" })
end)
require("ibl").setup {
  indent = { highlight = highlight },
  scope = { enabled = true },
}
