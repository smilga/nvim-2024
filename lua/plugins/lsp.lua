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
        local vue_language_server_path = vim.fn.stdpath('data') ..
            "/mason/packages/vue-language-server/node_modules/@vue/language-server"

        local vue_plugin = {
            name = '@vue/typescript-plugin',
            location = vue_language_server_path,
            languages = { 'vue' },
            configNamespace = 'typescript',
        }

        local vtsls = {
            cmd = { 'vtsls', '--stdio' },
            root_markers = { 'tsconfig.json', 'package.json', 'jsconfig.json', '.git' },
            single_file_support = true,
            filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
            settings = {
                vtsls = {
                    tsserver = {
                        globalPlugins = {
                            vue_plugin,
                        },
                    },
                },
            },
        }

        local vue_ls = {
            cmd = { 'vue-language-server', '--stdio' },
            filetypes = { 'vue' },
            root_markers = { 'package.json', '.git' },
            init_options = {
                typescript = {
                    tsdk = ''
                }
            },
            single_file_support = true,
            on_init = function(client)
                client.handlers['tsserver/request'] = function(_, result, context)
                    local clients = vim.lsp.get_clients({ bufnr = context.bufnr, name = 'vtsls' })
                    if #clients == 0 then
                        vim.notify('Could not found `vtsls` lsp client, vue_lsp would not work without it.',
                            vim.log.levels.ERROR)
                        return
                    end
                    local ts_client = clients[1]

                    local param = unpack(result)
                    local id, command, payload = unpack(param)
                    ts_client:exec_cmd({
                        title = 'vue_request_forward',
                        command = 'typescript.tsserverRequest',
                        arguments = {
                            command,
                            payload,
                        },
                    }, { bufnr = context.bufnr }, function(_, r)
                        local response_data = { { id, r.body } }
                        ---@diagnostic disable-next-line: param-type-mismatch
                        client:notify('tsserver/response', response_data)
                    end)
                end
            end,
        }

        local lua_ls = {
            cmd = { 'lua-language-server' },
            filetypes = { 'lua' },
            root_markers = { '.luarc.json', '.luarc.jsonc', '.luacheckrc', '.stylua.toml', 'stylua.toml', 'selene.toml', 'selene.yml', '.git' },
            single_file_support = true,
            log_level = vim.lsp.protocol.MessageType.Warning,
            on_init = function(client)
                local path = client.workspace_folders[1].name
                if vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc') then
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

        local gopls = {
            cmd = { 'gopls' },
            filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
            root_markers = { 'go.work', 'go.mod', '.git' },
            single_file_support = true,
            settings = {
                gopls = {
                    analyses = {
                        unusedparams = true,
                    },
                    staticcheck = true,
                    gofumpt = true,
                },
            },
        }

        local phpactor = {
            cmd = { 'phpactor', 'language-server' },
            filetypes = { 'php' },
            root_markers = { 'composer.json', '.git', '.phpactor.json', '.phpactor.yml' },
            on_attach = function(client)
                client.server_capabilities.hoverProvider = true
                client.server_capabilities.implementationProvider = true
                client.server_capabilities.referencesProvider = true
                client.server_capabilities.definitionProvider = true
                client.server_capabilities.documentFormattingProvider = true
                client.server_capabilities.documentRangeFormattingProvider = true
            end,
        }

        local golang_ci_lint_ls = {
            cmd = { 'golangci-lint-langserver' },
            filetypes = { 'go', 'gomod' },
            root_markers = { '.golangci.yml', '.golangci.yaml', '.golangci.toml', '.golangci.json', 'go.work', 'go.mod', '.git' },
            init_options = {
                command = { 'golangci-lint', 'run', '--output.json.path=stdout', '--show-stats=false' },
            },
        }

        local tailwindcss = {
            cmd = { 'tailwindcss-language-server', '--stdio' },
            filetypes = {
                'aspnetcorerazor', 'astro', 'astro-markdown', 'blade', 'clojure', 'django-html',
                'htmldjango', 'edge', 'eelixir', 'elixir', 'ejs', 'erb', 'eruby', 'gohtml',
                'gohtmltmpl', 'haml', 'handlebars', 'hbs', 'html', 'html-eex', 'heex', 'jade',
                'leaf', 'liquid', 'markdown', 'mdx', 'mustache', 'njk', 'nunjucks', 'php',
                'razor', 'slim', 'twig', 'css', 'less', 'postcss', 'sass', 'scss', 'stylus',
                'sugarss', 'javascript', 'javascriptreact', 'reason', 'rescript', 'typescript',
                'typescriptreact', 'vue', 'svelte', 'templ'
            },
            init_options = {
                userLanguages = {
                    eelixir = 'html-eex',
                    eruby = 'erb',
                    templ = 'html'
                }
            },
            root_markers = {
                'tailwind.config.js', 'tailwind.config.cjs', 'tailwind.config.mjs',
                'tailwind.config.ts', 'postcss.config.js', 'postcss.config.cjs',
                'postcss.config.mjs', 'postcss.config.ts', 'package.json', 'node_modules', '.git'
            },
            settings = {
                tailwindCSS = {
                    lint = {
                        cssConflict = 'warning',
                        invalidApply = 'error',
                        invalidConfigPath = 'error',
                        invalidScreen = 'error',
                        invalidTailwindDirective = 'error',
                        invalidVariant = 'error',
                        recommendedVariantOrder = 'warning'
                    },
                    validate = true
                }
            },
        }

        vim.lsp.config('vtsls', vtsls)
        vim.lsp.config('vue_ls', vue_ls)
        vim.lsp.config('lua_ls', lua_ls)
        vim.lsp.config('gopls', gopls)
        vim.lsp.config('phpactor', phpactor)
        vim.lsp.config('golang_ci_lint_ls', golang_ci_lint_ls)
        vim.lsp.config('tailwindcss', tailwindcss)

        vim.lsp.enable({
            'vtsls',
            'vue_ls',
            'lua_ls',
            'gopls',
            'phpactor',
            'eslint',
            'golang_ci_lint_ls',
            'tailwindcss',
        })
    end
}
