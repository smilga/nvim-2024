return {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = function()
        local npairs = require('nvim-autopairs')
        local Rule = require('nvim-autopairs.rule')

        npairs.setup({
            -- your setup options here
            ignore_next_char = "[%w%.]"
        })

        -- Custom rule for PHP method autocomplete with semicolon
        npairs.add_rules({
            Rule("%)$", ";", "php")
                :use_regex(true)
                :replace_endpair(function(opts)
                    local line = opts.line
                    local col = opts.col
                    local char_after = line:sub(col + 1, col + 1)
                    if opts.prev_char:match("%)$") and char_after:match("^%s*$") then
                        return ";"
                    else
                        return ""
                    end
                end)
                :set_end_pair_length(0)
        })
    end
}
