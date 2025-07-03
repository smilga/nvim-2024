return {
    cmd = { 'emmet-ls', '--stdio' },
    root_markers = { '.git' },
    single_file_support = true,
    filetypes = { "css", "eruby", "html", "javascript", "javascriptreact", "less", "sass", "scss", "svelte", "pug", "typescriptreact", "vue" },
    init_options = {
        html = {
            options = {
                -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
            },
        },
    }
}