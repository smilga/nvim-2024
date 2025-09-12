return {
	"folke/zen-mode.nvim",
	config = function()
		require("zen-mode").setup({
			window = {
				backdrop = 0.5,
				width = 140,
				options = {
					signcolumn = "no",
					number = true,
					relativenumber = true,
				},
			},
			on_open = function(win)
				vim.api.nvim_set_hl(0, "ZenBg", { bg = "NONE" })
			end,
		})
	end,
}
