vim.keymap.set("n", "<leader>w", "<cmd>write<cr>", { desc = "Save File" })
vim.keymap.set("i", "<Down>", "<C-\\><C-N><C-w>j")
vim.keymap.set("i", "<Up>", "<C-\\><C-N><C-w>k")
vim.keymap.set("i", "<Left>", "<C-\\><C-N><C-w>h")
vim.keymap.set("i", "<Right>", "<C-\\><C-N><C-w>l")
vim.keymap.set("t", "<Down>", "<C-\\><C-N><C-w>j")
vim.keymap.set("t", "<Up>", "<C-\\><C-N><C-w>k")
vim.keymap.set("t", "<Left>", "<C-\\><C-N><C-w>h")
vim.keymap.set("t", "<Right>", "<C-\\><C-N><C-w>l")

vim.keymap.set("n", "<Down>", "<C-W><C-J>")
vim.keymap.set("n", "<Up>", "<C-W><C-K>")
vim.keymap.set("n", "<Left>", "<C-W><C-H>")
vim.keymap.set("n", "<Right>", "<C-W><C-L>")
vim.keymap.set("n", "<leader>k", function()
	local buf = vim.api.nvim_buf_get_name(0)
	if string.sub(buf, 1, 5) == "fyler" then
		vim.cmd("bd")
	else
		vim.cmd("BD!")
	end
end)
vim.keymap.set("n", "<leader>p", "<cmd>:b#<cr>", { desc = "Go to previous buffer" })
vim.keymap.set("n", "<leader>r", "<cmd>:Spectre<cr>", { desc = "Find & Replace" })

-- Terminal mode
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]])
vim.api.nvim_set_keymap("t", "<Up>", "<C-p>", { noremap = true })
vim.api.nvim_set_keymap("t", "<Down>", "<C-n>", { noremap = true })

vim.keymap.set("n", "gd", function()
	require("utils.vue").gd_with_dts_resolver()
	-- vim.lsp.buf.definition({ on_list = on_list })
end, { desc = "Go to definition" })

vim.keymap.set("n", "<leader>cr", function()
	vim.lsp.buf.rename()
end, { desc = "Rename" })

vim.keymap.set("n", "<leader>ca", function()
	vim.lsp.buf.code_action()
end, { noremap = true, silent = true })

vim.keymap.set("n", "<leader>cf", function()
	vim.lsp.buf.format()
end, { desc = "Format" })

vim.keymap.set("n", "K", function()
	vim.lsp.buf.hover()
end, { desc = "Documentation" })

vim.keymap.set("n", "T", function()
	vim.diagnostic.open_float()
end, { desc = "Diagnostics float" })

vim.keymap.set("n", "<leader>cu", "<cmd>:Telescope lsp_references<cr>", { desc = "References" })
vim.keymap.set("n", "<leader>cd", "<cmd>:Telescope lsp_definitions<cr>", { desc = "Definitions" })
vim.keymap.set("n", "<leader>cs", "<cmd>:Telescope lsp_document_symbols<cr>", { desc = "Symbols" })
vim.keymap.set("n", "<leader>cn", "<cmd>:PhpActor new_class<cr>", { desc = "New PHP Class" })
vim.keymap.set("n", "<leader>ci", function()
	vim.lsp.buf.implementation()
end, { desc = "implementations" })
vim.keymap.set("n", "<leader>dd", "<cmd>:Trouble diagnostics toggle<cr>", { desc = "Trouble" })
vim.keymap.set("n", "<leader>db", "<cmd>:DapToggleBreakpoint<cr>", { desc = "Breakpoing" })
vim.keymap.set("n", "<leader>dc", "<cmd>:DapContinue<cr>", { desc = "Continue" })
vim.keymap.set("n", "<leader>ds", "<cmd>:lua require('dap').step_into()<cr>", { desc = "Step" })
vim.keymap.set("n", "<leader>do", "<cmd>:lua require('dap').step_out()<cr>", { desc = "Step Out" })
vim.keymap.set("n", "<leader>dn", "<cmd>:lua require('dap').step_over()<cr>", { desc = "Next" })
vim.keymap.set("n", "<leader>de", "<cmd>:lua require('dapui').eval()<cr>", { desc = "Eval" })
vim.keymap.set("n", "<leader>dh", "<cmd>:lua require('dap.ui.widgets').hover()<cr>", { desc = "Hover" })
vim.keymap.set("n", "<leader>dr", "<cmd>:lua require('dap').run_to_cursor()<cr>", { desc = "Run to cursor" })
vim.keymap.set("n", "<leader>dt", "<cmd>:lua require('dap-go').debug_test()<cr>", { desc = "Test to cursor" })
vim.keymap.set("n", "<leader>zz", "<cmd>:ZenMode<cr>", { desc = "Zen mode" })
vim.keymap.set("n", "<leader>hh", function()
	print(vim.inspect(vim.treesitter.get_captures_at_cursor()))
end, { desc = "HL Group" })

vim.keymap.set("n", "<leader>l", function()
	require("telescope.builtin").buffers({ sort_lastused = true })
end, { desc = "Buffers" })

-- Git related
vim.keymap.set("n", "<leader>go", "<cmd>:DiffviewOpen<cr>", { desc = "Diff View Open" })
vim.keymap.set("n", "<leader>gw", "<cmd>:DiffviewClose<cr>", { desc = "Diff View Close" })
vim.keymap.set("n", "<leader>gp", "<cmd>:Git push<cr>", { desc = "Git Push" })
vim.keymap.set("n", "<leader>gc", "<cmd>:Telescope git_commits<cr>", { desc = "Commits" })
vim.keymap.set("n", "<leader>gb", "<cmd>:Telescope git_branches<cr>", { desc = "Branches" })
vim.keymap.set("n", "<leader>gh", "<cmd>:Gitsigns preview_hunk<cr>", { desc = "Preview Hunk" })
vim.keymap.set("n", "<leader>gs", "<cmd>:Gitsigns stage_hunk<cr>", { desc = "Stage Hunk" })
vim.keymap.set("n", "<leader>gr", "<cmd>:Gitsigns reset_hunk<cr>", { desc = "Reset Hunk" })
vim.keymap.set("n", "<leader>gd", "<cmd>:Gitsigns diffthis<cr>", { desc = "Diff" })
vim.keymap.set("n", "<leader>gl", "<cmd>:Gitsigns blame_line<cr>", { desc = "Line Blame" })
vim.keymap.set("n", "<leader>gj", "<cmd>:Telescope git_status<cr>", { desc = "Status" })
vim.keymap.set("n", "<leader>gf", "<cmd>:Fugit2<cr>", { desc = "Fugit2 🎉" })
vim.keymap.set("n", "<leader>gg", "<cmd>:Git<cr>", { desc = "Git" })

vim.keymap.set("n", "<leader>wq", function()
	vim.cmd("NvimTreeClose")
	vim.cmd("wqa")
end, { desc = "🚪wqa" })

vim.keymap.set("n", "<leader>wa", function()
	vim.cmd("wa")
end, { desc = "💿" })

-- Working with files
vim.keymap.set("n", "<leader>o", "<cmd>:Fyler<cr>", { desc = "File buffer 🤯" })
vim.keymap.set("n", "<leader>m", "<cmd>:NvimTreeFindFileToggle<cr>", { desc = "File Tree Focus" })
vim.keymap.set("n", "<leader>f", function()
	require("telescope.builtin").find_files({
		find_command = {
			"rg",
			"--files",
			"--hidden",
			"--no-ignore",
			"--iglob",
			"!.git",
			"--iglob",
			"!node_modules",
			"--iglob",
			"!vendor",
		},
	})
end, { desc = "Find Files" })
vim.keymap.set("n", "<leader>tn", ":tabnew<CR>")
vim.keymap.set("n", "<leader>tc", ":tabclose<CR>")
vim.keymap.set("n", "<", ":tabprev<CR>")
vim.keymap.set("n", ">", ":tabnext<CR>")

vim.keymap.set("n", "<leader>s", "<cmd>:Telescope live_grep<cr>", { desc = "Find in files" })
vim.keymap.set("n", "<leader>u", "<cmd>:Navbuddy<cr>", { desc = "File structure" })
vim.keymap.set("i", "<S-Enter>", function()
	require("copilot.suggestion").accept()
end, { noremap = true, silent = true })

vim.keymap.set("n", "<leader>cca", function()
	vim.lsp.buf.code_action({
		filter = function(ca)
			return ca.isPreferred
		end, -- Optional: show only preferred actions
	})
end, { desc = "Code actions from all LSPs" })
