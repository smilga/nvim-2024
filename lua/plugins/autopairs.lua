return {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = function()
        local npairs = require('nvim-autopairs')
        local Rule = require('nvim-autopairs.rule')

        npairs.setup({
            check_ts = true
        })
        npairs.add_rules({
            Rule("'", "'")
                :with_pair(function(opts)
                    -- Check if we're inside double quotes
                    local line = opts.line
                    local col = opts.col

                    -- Count quotes before cursor to determine if we're inside string
                    local count = 0
                    for i = 1, col - 1 do
                        if line:sub(i, i) == '"' and line:sub(i - 1, i - 1) ~= '\\' then
                            count = count + 1
                        end
                    end

                    -- If count is odd, we're inside a string
                    -- Also check that next char isn't alphanumeric
                    local next_char = line:sub(col, col)
                    return count % 2 == 1 and not next_char:match("%w")
                end)
                :with_move(function(opts)
                    return opts.char == "'"
                end),

            Rule('"', '"')
                :with_pair(function(opts)
                    local next_char = opts.line:sub(opts.col, opts.col)
                    return not next_char:match("%w")
                end)
        })
    end
}
