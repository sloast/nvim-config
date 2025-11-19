vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function()
		-- Get existing diagnostic colors and apply them to virtual text
		local error_fg = vim.api.nvim_get_hl(0, { name = "DiagnosticError" }).fg
		local warn_fg = vim.api.nvim_get_hl(0, { name = "DiagnosticWarn" }).fg
		local info_fg = vim.api.nvim_get_hl(0, { name = "DiagnosticInfo" }).fg
		local hint_fg = vim.api.nvim_get_hl(0, { name = "DiagnosticHint" }).fg

		vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = error_fg, italic = true })
		vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { fg = warn_fg, italic = true })
		vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { fg = info_fg, italic = true })
		vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { fg = hint_fg, italic = true })
	end,
})

-- vim.cmd("colorscheme tokyonight")
vim.cmd("colorscheme everforest")
-- vim.cmd("colorscheme moonfly")
