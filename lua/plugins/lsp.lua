return {
    "neovim/nvim-lspconfig",
    dependencies = {
        {
            "SmiteshP/nvim-navbuddy",
            dependencies = {
                "SmiteshP/nvim-navic",
                "MunifTanjim/nui.nvim"
            },
            opts = { lsp = { auto_attach = true } }
        }
    },
    config = function()
        local navbuddy = require("nvim-navbuddy")
        local capabilities = require('cmp_nvim_lsp').default_capabilities()

        local lspconfig = require("lspconfig")
        lspconfig.lua_ls.setup {
            capabilities = capabilities,
            on_init = function(client)
                local path = client.workspace_folders[1].name
                if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then
                    return
                end

                client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                    runtime = {
                        version = 'LuaJIT'
                    },
                    workspace = {
                        checkThirdParty = false,
                        library = {
                            vim.env.VIMRUNTIME
                        }
                    }
                })
            end,
            on_attach = function(client, bufnr)
                client.server_capabilities.semanticTokensProvider = nil
                vim.api.nvim_create_autocmd("BufWritePre", {
                    buffer = bufnr,
                    callback = function()
                        vim.lsp.buf.format({ async = false })
                    end,
                })
            end,
            settings = {
                Lua = {}
            }
        }

        lspconfig.volar.setup {
            capabilities = capabilities,
            filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' },
            on_attach = function(client)
                client.server_capabilities.documentFormattingProvider = false
                client.server_capabilities.documentRangeFormattingProvider = false
            end,
        }

        lspconfig.eslint.setup {
            on_attach = function(client, bufnr)
                vim.api.nvim_create_autocmd("BufWritePre", {
                    buffer = bufnr,
                    command = "EslintFixAll",
                })
            end,
            capabilities = capabilities,
            filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' },
        }

        lspconfig.ts_ls.setup {
            on_attach = function(client, bufnr)
                client.server_capabilities.semanticTokensProvider = nil
                navbuddy.attach(client, bufnr)
                -- client.server_capabilities.documentFormattingProvider = false
                -- client.server_capabilities.documentRangeFormattingProvider = false
            end,
            capabilities = capabilities,
            init_options = {
                plugins = {
                    {
                        name = "@vue/typescript-plugin",
                        location = "/Users/smilga/.nvm/versions/node/v20.13.1/lib/node_modules/@vue/typescript-plugin",
                        languages = { "javascript", "typescript", "vue" },
                    },
                },
            },
            filetypes = {
                'typescript',
                'javascript',
                'javascriptreact',
                'typescriptreact',
                'vue'
            },
        }

        lspconfig.golangci_lint_ls.setup {
            capabilities = capabilities,
        }

        lspconfig.gopls.setup({
            capabilities = capabilities,
            settings = {
                gopls = {
                    analyses = {
                        unusedparams = true,
                    },
                    staticcheck = true,
                    gofumpt = true,
                },
            },
        })
        lspconfig.quick_lint_js.setup {
            capabilities = capabilities,
        }

        lspconfig.intelephense.setup {
            capabilities = capabilities,
            on_attach = function(client)
                client.server_capabilities.hoverProvider = true
                client.server_capabilities.implementationProvider = true
                client.server_capabilities.referencesProvider = true
                client.server_capabilities.definitionProvider = true
                client.server_capabilities.documentFormattingProvider = false
                client.server_capabilities.documentRangeFormattingProvider = false
            end,
            init_options = {
                licenceKey = "/Users/smilga/.config/intelephense_licence.txt",
            },
            settings = {
                intelephense = {
                    files = {
                        maxSize = 3000000,
                    },
                    completion = {
                        insertUseDeclaration = true, -- Automatically add use declarations
                    },
                },
            },
        }
        lspconfig.phpactor.setup {
            capabilities = capabilities,
            on_attach = function(client)
                client.server_capabilities.hoverProvider = false
                client.server_capabilities.implementationProvider = false
                client.server_capabilities.referencesProvider = false
                client.server_capabilities.definitionProvider = false
                client.server_capabilities.documentFormattingProvider = false
                client.server_capabilities.documentRangeFormattingProvider = false
            end,
        }
        lspconfig.emmet_ls.setup({
            capabilities = capabilities,
            filetypes = { "css", "eruby", "html", "javascript", "javascriptreact", "less", "sass", "scss", "svelte", "pug", "typescriptreact", "vue" },
            init_options = {
                html = {
                    options = {
                        -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
                    },
                },
            }
        })
        lspconfig.tailwindcss.setup {}
    end
}
