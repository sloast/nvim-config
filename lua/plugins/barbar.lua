return {
	"romgrk/barbar.nvim",
	dependencies = "nvim-tree/nvim-web-devicons",
	init = function()
		vim.g.barbar_auto_setup = false
	end,
	config = function()
		require("barbar").setup()
	end,
	keys = {
		{ "<Tab>", "<cmd>BufferNext<cr>" },
		{ "<S-Tab>", "<cmd>BufferPrevious<cr>" },
		{ "<leader>x", "<cmd>BufferClose<cr>" },
	},
}
