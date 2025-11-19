return {
	"HiPhish/rainbow-delimiters.nvim",
	"marko-cerovac/material.nvim",
	{ "kepano/flexoki-neovim", name = "flexoki" },
	{
		"sainnhe/everforest",
		priority = 1000,
		config = function()
			-- Configuration
			vim.g.everforest_background = "hard" -- 'hard', 'medium', 'soft'
			vim.g.everforest_better_performance = 1
			vim.g.everforest_enable_italic = 1
		end,
	},
	{
		"folke/tokyonight.nvim",
		config = function()
			require("tokyonight").setup({
				style = "night",
				transparent = false,
			})
		end,
	},
	{ "bluz71/vim-moonfly-colors", name = "moonfly", lazy = false, priority = 1000 },
}
