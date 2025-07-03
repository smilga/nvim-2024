return function(capabilities)
    return {
        capabilities = capabilities,
        on_attach = function(client)
            client.server_capabilities.hoverProvider = true
            client.server_capabilities.implementationProvider = true
            client.server_capabilities.referencesProvider = true
            client.server_capabilities.definitionProvider = true
            client.server_capabilities.documentFormattingProvider = true
            client.server_capabilities.documentRangeFormattingProvider = true
        end,
    }
end