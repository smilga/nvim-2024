return {
    'glepnir/template.nvim',
    dependencies = {
        'nvim-telescope/telescope.nvim',
    },
    config = function()
        local template = require('template')
        local telescope = require('telescope.builtin')

        template.setup({
            temp_dir = '~/.config/nvim/templates',
        })

        local function get_template_files()
            local templates = {}
            local handle = io.popen('ls ' .. vim.fn.expand('~/.config/nvim/templates/*'))
            if handle then
                for file in handle:lines() do
                    local name = file:match("[^/]+$")
                    if name then
                        templates[name] = file
                    end
                end
                handle:close()
            end
            return templates
        end

        -- -- Custom telescope picker for templates
        local function telescope_templates()
            local templates = get_template_files()
            local template_names = {}

            -- Get sorted list of template names
            for name, _ in pairs(templates) do
                table.insert(template_names, name)
            end
            table.sort(template_names)

            -- Create picker
            vim.ui.select(template_names, {
                prompt = "Select template:",
                format_item = function(item)
                    return item
                end,
            }, function(choice)
                if choice then
                    -- Prompt for filename
                    vim.ui.input({
                        prompt = "Enter filename: ",
                    }, function(filename)
                        if filename and filename ~= "" then
                            vim.cmd(string.format("Template %s %s", filename, choice))
                        end
                    end)
                end
            end)
        end
        --
        vim.api.nvim_create_user_command('TemplateSelect', telescope_templates, {})
        vim.keymap.set('n', '<leader>nt', telescope_templates, { noremap = true, silent = true })
    end
}
