return {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        require("nvim-tree").setup({
            update_focused_file = {
                enable = true,
                update_root = false,
            },
            view = {
                width = 40,
            },
            git = {
                enable = true,
                ignore = false,
                timeout = 500,
            },
        })
    end,
}
