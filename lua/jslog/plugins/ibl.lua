local highlight = {
    "RainbowRed",
}

local hooks = require "ibl.hooks"
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    -- The use of RainbowRed here is a bit of a hack.
    -- Really all I want is a dark verticle line which
    -- is what the #444444 does. But I haven't figured
    -- the syntax out sufficiently to achieve that without
    -- a known constant in here.
    vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#444444" })
end)
require("ibl").setup {
  -- Similar to above. I don't know why I need to use
  -- the highlight object, but apparently I do.
  indent = { highlight = highlight },
  scope = { enabled = true },
}
