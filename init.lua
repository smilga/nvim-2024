require("config")
require("setup-lazy")
require("keys")

require("lazy").setup("plugins")

vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = '', -- or other icon of your choice here, this is just what my config has:
            [vim.diagnostic.severity.WARN] = '',
            [vim.diagnostic.severity.INFO] = '',
            [vim.diagnostic.severity.HINT] = '󰌵',
        },
    },
})
