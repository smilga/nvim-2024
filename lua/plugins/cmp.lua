local kind_icons = {
    Text = "",
    Method = "󰆧",
    Function = "󰊕",
    Constructor = "",
    Field = "󰇽",
    Variable = "󰂡",
    Class = "󰠱",
    Interface = "",
    Module = "",
    Property = "󰜢",
    Unit = "",
    Value = "󰎠",
    Enum = "",
    Keyword = "󰌋",
    Snippet = "",
    Color = "󰏘",
    File = "󰈙",
    Reference = "",
    Folder = "󰉋",
    EnumMember = "",
    Constant = "󰏿",
    Struct = "",
    Event = "",
    Operator = "󰆕",
    TypeParameter = "󰅲",
}

return {
    'hrsh7th/nvim-cmp',
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
        {
            "hrsh7th/cmp-nvim-lsp",
            'saadparwaiz1/cmp_luasnip',
        },
    },
    config = function()
        local cmp = require('cmp')
        local luasnip = require("luasnip")

        cmp.setup {
            sorting = {
                comparators = {
                    require('utils.emmet').emmet_comparator,
                    cmp.config.compare.offset,
                    cmp.config.compare.exact,
                    cmp.config.compare.score,
                    cmp.config.compare.kind,
                    cmp.config.compare.sort_text,
                    cmp.config.compare.length,
                    cmp.config.compare.order,
                },
            },
            formatting = {
                format = function(entry, vim_item)
                    -- Kind icons
                    vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatenates the icons with the name of the item kind
                    -- Source
                    vim_item.menu = ({
                        buffer = "[Buffer]",
                        nvim_lsp = "[LSP]",
                        luasnip = "[LuaSnip]",
                        nvim_lua = "[Lua]",
                        latex_symbols = "[LaTeX]",
                    })[entry.source.name]
                    return vim_item
                end
            },
            mapping = {
                ['<C-d>'] = require('cmp').mapping.scroll_docs(-4),
                ['<C-f>'] = require('cmp').mapping.scroll_docs(4),
                ['<C-Space>'] = require('cmp').mapping.complete(),
                ['<C-e>'] = require('cmp').mapping.close(),
                ['<CR>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        if luasnip.expandable() then
                            luasnip.expand()
                        else
                            cmp.confirm({
                                select = true,
                            })
                        end
                    elseif vim.fn.pumvisible() == 0 and require("copilot.suggestion").is_visible() then
                        require("copilot.suggestion").accept()
                    else
                        fallback()
                    end
                end),

                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.locally_jumpable(1) then
                        luasnip.jump(1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),

                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            },
            sources = {
                { name = 'luasnip' },
                { name = 'nvim_lsp' },
                { name = 'buffer' },
            },
        }


        local cmp_autopairs = require('nvim-autopairs.completion.cmp')
        local cmp = require('cmp')
        cmp.event:on(
            'confirm_done',
            cmp_autopairs.on_confirm_done()
        )
    end,
}
