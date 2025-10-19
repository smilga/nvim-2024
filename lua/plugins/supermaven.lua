return {
    "supermaven-inc/supermaven-nvim",
    config = function()
        require("supermaven-nvim").setup({
            color = {
                suggestion_color = "#555599",
                cterm = 8,
            },
        })
    end,
}
