local tokyotheme = require("tokyonight")
tokyotheme.setup({
    on_colors = function(colors)
        -- default gutter numbers are too feint to read
        colors.fg_gutter = "#ffffff"
        -- default comments are too feint to read
        colors.comment = "#9999dd"
    end
})
