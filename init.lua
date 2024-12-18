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

vim.filetype.add({
    filename = {
        ["compose.yaml"] = "yaml.docker-compose",
    },
})
vim.api.nvim_create_autocmd("FileType", {
    pattern = "yaml.docker-compose",
    callback = function()
        vim.opt_local.shiftwidth = 2
        vim.opt_local.tabstop = 2
        vim.opt_local.expandtab = true
    end,
})
