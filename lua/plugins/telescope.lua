return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"nvim-telescope/telescope-media-files.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
	},
	cmd = "Telescope",
	keys = {
		{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
		{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
		{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find buffers" },
		{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
		{ "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent files" },
		{ "<leader>fw", "<cmd>Telescope grep_string<cr>", desc = "Find word under cursor" },
		{ "<leader>fc", "<cmd>Telescope commands<cr>", desc = "Commands" },
		{ "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
		{ "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document symbols" },
		{ "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
		{ "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Search in buffer" },
		{ "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Git commits" },
		{ "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "Git status" },
		{ "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Git branches" },
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				prompt_prefix = "🔍 ",
				selection_caret = "➜ ",
				path_display = { "truncate" },
				sorting_strategy = "ascending",
				layout_strategy = "horizontal",
				layout_config = {
					horizontal = {
						prompt_position = "top",
						preview_width = 0.55,
						results_width = 0.8,
					},
					vertical = {
						mirror = false,
					},
					width = 0.87,
					height = 0.80,
					preview_cutoff = 120,
				},
				file_ignore_patterns = {
					"node_modules",
					".git/",
					"target/",
					"build/",
					"dist/",
					"%.lock",
				},
				mappings = {
					i = {
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
						["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
						["<C-x>"] = actions.select_horizontal,
						["<C-v>"] = actions.select_vertical,
						["<C-t>"] = actions.select_tab,
						["<C-u>"] = actions.preview_scrolling_up,
						["<C-d>"] = actions.preview_scrolling_down,
					},
					n = {
						["q"] = actions.close,
						["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
					},
				},
			},
			pickers = {
				find_files = {
					hidden = true,
					find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" },
				},
				live_grep = {
					additional_args = function()
						return { "--hidden" }
					end,
				},
				buffers = {
					sort_mru = true,
					mappings = {
						i = {
							["<C-d>"] = actions.delete_buffer,
						},
					},
				},
			},
			extensions = {
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
				media_files = {
					filetypes = { "png", "jpg", "jpeg", "gif", "webp", "pdf" },
					find_cmd = "rg",
				},
			},
		})

		-- Load extensions
		telescope.load_extension("fzf")
		telescope.load_extension("media_files")
	end,
}
