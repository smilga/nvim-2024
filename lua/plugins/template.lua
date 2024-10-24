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
            local template_dir = vim.fn.expand('~/.config/nvim/templates')

            if vim.fn.isdirectory(template_dir) ~= 1 then
                return templates
            end

            local files = vim.fn.glob(template_dir .. '/*', false, true)
            for _, file in ipairs(files) do
                local name = vim.fn.fnamemodify(file, ':t') -- Get filename only
                if name and name ~= '' then
                    templates[name] = file
                end
            end

            return templates
        end

        local function get_target_directory()
            local project_root = vim.fn.getcwd()

            local current_buf = vim.api.nvim_get_current_buf()
            local buf_name = vim.api.nvim_buf_get_name(current_buf)

            if buf_name and buf_name ~= '' then
                local buf_dir = vim.fn.fnamemodify(buf_name, ':h')

                local relative_path = string.sub(buf_dir, #project_root + 2) -- +2 to account for the trailing slash

                if relative_path and relative_path ~= '' then
                    return relative_path
                end
            end

            return ''
        end

        local function telescope_templates()
            local templates = get_template_files()
            local template_names = {}

            -- Get sorted list of template names
            for name, _ in pairs(templates) do
                table.insert(template_names, name)
            end
            table.sort(template_names)

            if #template_names == 0 then
                return
            end

            -- Create picker
            vim.ui.select(template_names, {
                prompt = "Select template:",
                format_item = function(item)
                    return item
                end,
            }, function(choice)
                if choice then
                    local template_name = vim.fn.fnamemodify(choice, ':r')

                    vim.ui.input({
                        prompt = "Enter filename: ",
                    }, function(filename)
                        if filename and filename ~= "" then
                            local target_dir = get_target_directory()
                            local full_path = target_dir .. '/' .. filename

                            local cmd = string.format("Template %s %s", full_path, template_name)
                            vim.notify('Executing: ' .. cmd, vim.log.levels.DEBUG)
                            vim.cmd(cmd)
                        end
                    end)
                end
            end)
        end
        -- :Template foobarbaz.ts typescritp_nuxt_composable

        -- Create user command and keymapping
        vim.api.nvim_create_user_command('TemplateSelect', telescope_templates, {})
        vim.keymap.set('n', '<leader>nt', telescope_templates, { noremap = true, silent = true })
    end
}
