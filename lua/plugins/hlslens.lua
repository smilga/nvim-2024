return {
    'kevinhwang91/nvim-hlslens',
    config = function()
        require('hlslens').setup({
            calm_down = true,
        })
        require('hlslens').start();
    end,
}
