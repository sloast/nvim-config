require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"python",
		"lua",
		"vim",
		"vimdoc",
		"javascript",
		"typescript",
		"yaml",
		"java",
	},

	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,

	-- Automatically install missing parsers when entering buffer
	auto_install = true,

	highlight = {
		enable = true,
		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		additional_vim_regex_highlighting = false,
	},

	-- Enable folding
	fold = {
		enable = true,
	},

	-- Optional: other modules you might want
	indent = {
		enable = true,
	},
})
