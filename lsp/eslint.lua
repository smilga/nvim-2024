return {
    cmd = { 'vscode-eslint-language-server', '--stdio' },
    root_markers = {
        '.eslintrc',
        '.eslintrc.js',
        '.eslintrc.cjs',
        '.eslintrc.yaml',
        '.eslintrc.yml',
        '.eslintrc.json',
        'eslint.config.js',
        'eslint.config.mjs',
        'eslint.config.cjs',
        'eslint.config.ts',
        'eslint.config.mts',
        'eslint.config.cts',
        'package.json'
    },
    settings = {
        eslint = {
            validate = 'on',
            workingDirectory = { mode = 'location' },
        },
    },
    on_attach = function(client)
        if not client.server_capabilities.semanticTokensProvider then
            client.server_capabilities.semanticTokensProvider = nil
        end
    end,
    filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
}