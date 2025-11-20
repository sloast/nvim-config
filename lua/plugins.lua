return {
	{ "Olical/nfnl", ft = "fennel" },
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {},
	},

	-- Git
	"lewis6991/gitsigns.nvim",
	-- {
	-- 	"nicolasgb/jj.nvim",
	-- 	config = function()
	-- 		require("jj").setup({})
	-- 	end,
	-- },
	"MunifTanjim/nui.nvim",
	{
		"julienvincent/hunk.nvim",
		cmd = { "DiffEditor" },
		config = function()
			require("hunk").setup()
		end,
	},

	{
		"luukvbaal/statuscol.nvim",
		config = function()
			local builtin = require("statuscol.builtin")
			require("statuscol").setup({
				-- configuration goes here, for example:
				-- relculright = true,
				segments = {
					{ text = { "%C" }, click = "v:lua.ScFa" },
					{ text = { "%s" }, click = "v:lua.ScSa" },
					{
						text = { builtin.lnumfunc },
						condition = { true, builtin.not_empty },
						click = "v:lua.ScLa",
					},
					{ text = { "│" }, hl = "LineNr" },
				},
			})
		end,
	},

	-- Editing
	"numToStr/Comment.nvim",
	"windwp/nvim-autopairs",
	"tpope/vim-surround",
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function()
			require("which-key").setup()
		end,
	},
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},

	{ "nvim-treesitter/nvim-treesitter", branch = "master", lazy = false, build = ":TSUpdate" },
	{ "tpope/vim-sleuth" },
}
