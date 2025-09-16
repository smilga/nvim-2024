local M = {}

function M.setup()
	vim.api.nvim_create_autocmd("FileType", {
		pattern = { "Avante", "AvanteSelectedFiles", "AvanteInput" },
	})
end

return M
