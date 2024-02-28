local tokyotheme = require("tokyonight")
tokyotheme.setup({
    -- default gutter numbers are too feint to read
    on_colors = function(colors)
        colors.fg_gutter = "#ffffff"
    end
})
