vim.keymap.set("n", "<leader>w", "<cmd>write<cr>", { desc = "Save File" })
vim.keymap.set("i", "<C-J>", "<C-\\><C-N><C-w>j")
vim.keymap.set("i", "<C-K>", "<C-\\><C-N><C-w>k")
vim.keymap.set("i", "<C-H>", "<C-\\><C-N><C-w>h")
vim.keymap.set("i", "<C-L>", "<C-\\><C-N><C-w>l")
vim.keymap.set("t", "<C-J>", "<C-\\><C-N><C-w>j")
vim.keymap.set("t", "<C-K>", "<C-\\><C-N><C-w>k")
vim.keymap.set("t", "<C-H>", "<C-\\><C-N><C-w>h")
vim.keymap.set("t", "<C-L>", "<C-\\><C-N><C-w>l")

vim.keymap.set("n", "<down>", "<C-W><C-J>")
vim.keymap.set("n", "<up>", "<C-W><C-K>")
vim.keymap.set("n", "<left>", "<C-W><C-H>")
vim.keymap.set("n", "<right>", "<C-W><C-L>")
vim.keymap.set("n", "<leader>k", "<cmd>BD!<cr>", { desc = "Kill Buffer" })

vim.keymap.set("n", "gd", function()
    vim.lsp.buf.definition({ on_list = on_list })
end, opts)

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
vim.keymap.set("n", "<leader>d", "<cmd>:Trouble diagnostics toggle<cr>", { desc = "Trouble" })
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

-- Working with files
vim.keymap.set("n", "<leader>o", "<cmd>:Oil<cr>", { desc = "File buffer 🤯" })
vim.keymap.set("n", "<leader>n", "<cmd>:NvimTreeToggle<cr>", { desc = "File Tree" })
vim.keymap.set("n", "<leader>m", "<cmd>:NvimTreeFindFileToggle<cr>", { desc = "File Tree Focus" })
vim.keymap.set("n", "<leader>f",
    function() require("telescope.builtin").find_files({ find_command = { "rg", "--files", "--iglob", "!.git" } }) end,
    { desc = "Find Files" }
)
vim.keymap.set("n", "<leader>s", "<cmd>:Telescope live_grep<cr>", { desc = "Find in files" })
vim.keymap.set("n", "<leader>p", "<cmd>:Navbuddy<cr>", { desc = "File structure" })
vim.keymap.set('i', '<S-Enter>', function() require("copilot.suggestion").accept() end, { noremap = true, silent = true })
