vim.api.nvim_create_autocmd("BufRead", {
    pattern = "components.d.ts",
    callback = function()
        vim.defer_fn(function()
            local line = vim.fn.getline('.')
            local component_path = string.match(line, "import%(\"(.-)\"%)%['default'%]")

            if component_path then
                local components_ts_path = vim.fn.expand('%:p:h')
                local absolute_path = vim.fn.simplify(components_ts_path .. '/' .. component_path)

                if vim.fn.filereadable(absolute_path) == 1 then
                    local components_bufnr = vim.fn.bufnr('%')
                    vim.cmd('edit ' .. absolute_path)
                    vim.cmd('bd ' .. components_bufnr)
                else
                    print("Warning: File not found:", absolute_path)
                end
            else
                print("No component path found in current line")
            end
        end, 10)
    end
})
