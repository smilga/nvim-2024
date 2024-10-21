local M = {}

local function is_inside_tag()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    local line_text = vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]
    local left_of_cursor = line_text:sub(1, col)
    -- Check if there's a '<' character in the line and we're not at the start
    return left_of_cursor:match("<") ~= nil and not left_of_cursor:match("^%s*$")
end

M.emmet_comparator = function(entry1, entry2)
    local kind1 = entry1:get_kind()
    local kind2 = entry2:get_kind()

    -- Emmet snippets have kind 15 (Snippet)
    if kind1 == 15 or kind2 == 15 then
        if is_inside_tag() then
            -- Inside a tag, always deprioritize Emmet snippets
            return kind1 ~= 15
        else
            -- At the start of a line or outside a tag, prioritize Emmet snippets
            return kind1 == 15
        end
    end

    -- For all other cases, maintain default behavior
    return nil
end

return M
