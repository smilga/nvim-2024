vim.g.mapleader = ","
vim.g.maplocalleader = ","
vim.opt.number = true
vim.opt.cmdheight = 1
vim.opt.cursorcolumn = false
vim.opt.cursorline = false
vim.opt.signcolumn = "yes"
vim.opt.swapfile = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.wrap = false
vim.opt.breakindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.clipboard = "unnamedplus"
vim.opt.termguicolors = true
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true
vim.opt.pumheight = 15
vim.opt.relativenumber = true
vim.opt.formatoptions = vim.opt.formatoptions - { 't' }

vim.filetype.add({
    extension = {
        ["http"] = "http",
    },
})

vim.diagnostic.config({ virtual_text = false })
