-- Setup Mason
require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = { "pyright", "ruff" },
})

-- Use new vim.lsp.config API (Neovim 0.11+)
vim.lsp.config("pyright", {
	settings = {
		python = {
			analysis = {
				typeCheckingMode = "basic",
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
			},
		},
	},
})

vim.lsp.config("ruff", {
	init_options = {
		settings = {
			args = {},
		},
	},
})

-- Enable LSP for filetypes
vim.api.nvim_create_autocmd("FileType", {
	pattern = "python",
	callback = function()
		vim.lsp.enable("pyright")
		vim.lsp.enable("ruff")
	end,
})

-- LSP Keybindings
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, { desc = "Format" })

-- Auto-format on save
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.py",
	callback = function()
		vim.lsp.buf.format()
	end,
})
