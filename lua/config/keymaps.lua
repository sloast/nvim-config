-- Normal mode
vim.keymap.set("n", "ZB", function()
	if vim.bo.modified then
		vim.cmd("write")
	end
	vim.cmd("bdelete")
end, { desc = "Save and close buffer" })
vim.keymap.set("n", "ZX", ":bdelete!<CR>", { desc = "Close buffer without saving" })
vim.keymap.set({ "n", "v" }, "+", '"+')

-- Insert mode
vim.keymap.set("i", "<C-H>", "<C-W>", { desc = "Delete word backwards" })
vim.keymap.set("i", "<C-z>", "<C-o>u", { desc = "Undo in insert mode" })

-- Terminal
vim.keymap.set("n", "<leader>tt", function()
	vim.cmd("term fish")
	vim.cmd("startinsert")
end, { desc = "Open terminal with fish" })
vim.keymap.set("n", "<leader>tn", function()
	vim.cmd("term nu")
	vim.cmd("startinsert")
end, { desc = "Open terminal with nushell" })
vim.keymap.set("t", "<C-Esc>", "<C-\\><C-n>")

-- LSP Keybindings
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Open diagnostic float" })
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, { desc = "Format" })
