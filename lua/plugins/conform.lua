return {
    "stevearc/conform.nvim",
    config = function()
        require("conform").setup({
            formatters = {
                ceslint = function(bufnr)
                    return {
                        command = vim.cmd("lua vim.lsp.buf.format()"),
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
                vue = { "ceslint", "crustywind" },
                typescript = { "ceslint" },
                javascript = { "ceslint" },
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
