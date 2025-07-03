local M = {}

function M.setup()
    local capabilities = require('blink.cmp').get_lsp_capabilities()
    
    local lua_ls_config = require('lsp.lua_ls')(capabilities)
    local eslint_config = require('lsp.eslint')(capabilities)
    local gopls_config = require('lsp.gopls')(capabilities)
    local golangci_lint_ls_config = require('lsp.golangci_lint_ls')(capabilities)
    local phpactor_config = require('lsp.phpactor')(capabilities)
    local emmet_ls_config = require('lsp.emmet_ls')(capabilities)
    local jsonls_config = require('lsp.jsonls')(capabilities)
    local docker_compose_ls_config = require('lsp.docker_compose_language_service')(capabilities)
    local vtsls_config = require('lsp.vtsls')(capabilities)
    local vue_ls_config = require('lsp.vue_ls')(capabilities)
    
    vim.lsp.config('lua_ls', lua_ls_config)
    vim.lsp.config('eslint', eslint_config)
    vim.lsp.config('gopls', gopls_config)
    vim.lsp.config('golangci_lint_ls', golangci_lint_ls_config)
    vim.lsp.config('phpactor', phpactor_config)
    vim.lsp.config('emmet_ls', emmet_ls_config)
    vim.lsp.config('jsonls', jsonls_config)
    vim.lsp.config('docker_compose_language_service', docker_compose_ls_config)
    vim.lsp.config('vtsls', vtsls_config)
    vim.lsp.config('vue_ls', vue_ls_config)
    
    vim.lsp.enable({
        'lua_ls',
        'eslint',
        'gopls',
        'golangci_lint_ls',
        'phpactor',
        'emmet_ls',
        'jsonls',
        'docker_compose_language_service',
        'vtsls',
        'vue_ls',
        'tailwindcss'
    })
end

return M
