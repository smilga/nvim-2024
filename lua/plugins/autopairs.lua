return {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = function()
        local npairs = require('nvim-autopairs')
        local Rule = require('nvim-autopairs.rule')

        npairs.setup({
            -- your setup options here
        })

        -- Custom rule for PHP method autocomplete with semicolon
        npairs.add_rules({
            Rule("%)$", ";", "php")
                :use_regex(true)
                :replace_endpair(function(opts)
                    return opts.prev_char:match("%)$") and ";" or ""
                end)
                :set_end_pair_length(0)
        })
    end
}
