return {
	"olimorris/persisted.nvim",
	config = function()
		require("persisted").setup({
			autoload = true,
		})
		vim.api.nvim_create_autocmd("User", {
			pattern = "PersistedSavePre",
			callback = function()
				vim.cmd("silent! :NvimTreeClose")

				local ok_dapui, dapui = pcall(require, "dapui")
				if ok_dapui then
					dapui.close()
				end
			end,
		})
	end,
}
