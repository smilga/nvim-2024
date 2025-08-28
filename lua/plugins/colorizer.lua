return {
    "norcalli/nvim-colorizer.lua",
    event = "VeryLazy",
    config = function()
        require("colorizer").setup({
            "*", -- Highlight all files, but customize some others.
            css = { rgb_fn = true }, -- Enable parsing rgb(...) functions in css.
            html = { names = false }, -- Disable parsing "names" in html.
        })
    end,
}
