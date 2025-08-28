return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		icons = {
			group = "",
		},
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
	config = function()
		local wk = require("which-key")
		wk.add({
			{ "<leader>a", desc = "AI" },
		})
		wk.add({
			{ "<leader>d", desc = "🐛 Debug" },
		})
	end,
}
