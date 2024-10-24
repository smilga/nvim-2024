local M = {}

local function is_inside_tag()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    local line_text = vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]
    local left_of_cursor = line_text:sub(1, col)
    return left_of_cursor:match("<") ~= nil and not left_of_cursor:match("^%s*$")
end

M.emmet_comparator = function(entry1, entry2)
    local kind1 = entry1:get_kind()
    local kind2 = entry2:get_kind()
    local is_luasnip1 = entry1.source.name == "luasnip"
    local is_luasnip2 = entry2.source.name == "luasnip"

    if is_luasnip1 and not is_luasnip2 then
        return true
    elseif is_luasnip2 and not is_luasnip1 then
        return false
    end

    -- Handle Emmet snippets (kind 15)
    if kind1 == 15 or kind2 == 15 then
        if is_inside_tag() then
            -- Inside a tag, deprioritize Emmet snippets
            return kind1 ~= 15 and kind2 == 15
        else
            -- Outside tag, prioritize Emmet snippets
            return kind1 == 15 and kind2 ~= 15
        end
    end

    -- For equal priority, return false
    return false
end

return M
