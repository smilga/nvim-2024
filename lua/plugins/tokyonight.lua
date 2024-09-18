return {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function ()
        require("tokyonight").setup({
            style = "night",
            on_highlights = function(highlights, colors)
                highlights["@variable"] = "@variable.member"
            end
        })
    end
}
