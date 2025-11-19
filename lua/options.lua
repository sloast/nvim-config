-- tabs
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4 -- Tab width
vim.opt.smartindent = true -- Smart auto-indent
vim.opt.autoindent = true

-- line numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 2

-- folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99

vim.opt.undofile = true

vim.opt.guicursor:append("t:block-blinkon0")

vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight_yank", {}),
	desc = "Hightlight selection on yank",
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 250 })
	end,
})
