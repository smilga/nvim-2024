require("config")
require("setup-lazy")
require("keys")

require("lazy").setup("plugins")

-- require("utils.avante").setup()
--
vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "", -- or other icon of your choice here, this is just what my config has:
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.HINT] = "󰌵",
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

-- vim.cmd.colorscheme "tokyonight-storm"

vim.cmd.colorscheme "catppuccin-macchiato"

local colors = require('catppuccin.palettes').get_palette("macchiato")
vim.api.nvim_set_hl(0, '@vue.directive_value', { fg = colors.yellow, bg = colors.none, bold = true })
vim.api.nvim_set_hl(0, '@constructor', { fg = colors.blue, bg = colors.none, bold = true })
