return {
    "stevearc/conform.nvim",
    config = function()
        require("conform").setup({
            formatters = {
                eslint_d = function(bufnr)
                    return {
                        command = "eslint_d",
                        args = { "--fix-to-stdout", "--stdin", "--stdin-filename", "$FILENAME" },
                        stdin = true,
                    }
                end,
                crustywind = function(bufnr)
                    return {
                        command = "rustywind",
                        args = {
                            "--stdin",
                        },
                        stdin = true,
                    }
                end,
            },
            format_on_save = {
                lsp_fallback = true,
                timeout_ms = 500,
            },
            notify_on_error = true,
            formatters_by_ft = {
                vue = { "eslint_d", "crustywind" },
                typescript = { "eslint_d" },
                javascript = { "eslint_d" },
                lua = { "stylua" },
                go = { "goimports" },
                -- Use the "*" filetype to run formatters on all filetypes.
                ["*"] = { "codespell" },
                -- Use the "_" filetype to run formatters on filetypes that don't
                -- have other formatters configured.
                ["_"] = { "trim_whitespace" },
            },
        })
    end,
}
