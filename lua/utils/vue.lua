local M = {}

local function resolve_path()
    local line = vim.api.nvim_get_current_line()
    local file_path = line:match("import%('(.-)'%)")

    if file_path then
        local search_path = file_path:gsub("^@/", ""):gsub("^./", "")

        local cmd
        if vim.fn.executable('fd') == 1 then
            cmd = string.format("fd -t f -p '%s' %s", search_path, vim.fn.getcwd())
        else
            cmd = string.format("find %s -type f -path '*%s*'", vim.fn.getcwd(), search_path)
        end

        local found_files = vim.fn.systemlist(cmd)
        vim.notify(vim.inspect(found_files), vim.log.levels.INFO)

        if #found_files > 0 then
            return found_files[1]
        end
    end
    return nil
end

function M.gd_with_dts_resolver()
    if vim.bo.filetype ~= "vue" then
        return vim.lsp.buf.definition()
    end

    local original_handler = vim.lsp.handlers["textDocument/definition"]

    vim.lsp.handlers["textDocument/definition"] = function(err, result, ctx, config)
        vim.lsp.handlers["textDocument/definition"] = original_handler

        original_handler(err, result, ctx, config)

        vim.schedule(function()
            local dtsBuf = vim.api.nvim_get_current_buf()
            local new_file = vim.api.nvim_buf_get_name(dtsBuf)

            if new_file:match("components.d.ts$") then
                local component_path = resolve_path()
                if component_path then
                    vim.cmd("edit " .. component_path)
                else
                    vim.notify("Component file not found!", vim.log.levels.WARN)
                end
            end
        end)
    end

    vim.lsp.buf.definition()
end

return M
