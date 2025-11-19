function alx_telescope_config(title)
	return {
		prompt_title = title,
		cwd = "~/dev/arcticlake",
		search_dirs = {
			vim.fn.expand("~/dev/arcticlake/alx"),
			vim.fn.expand("~/dev/arcticlake/infra"),
		},
		path_display = function(opts, path)
			local alx_path = vim.fn.expand("~/dev/arcticlake/alx")
			local infra_path = vim.fn.expand("~/dev/arcticlake/infra")

			if vim.startswith(path, alx_path) then
				path = path:sub(#alx_path + 2)
			elseif vim.startswith(path, infra_path) then
				path = path:sub(#infra_path + 2)
			end

			local dir = vim.fn.fnamemodify(path, ":h")
			local filename = vim.fn.fnamemodify(path, ":t")

			if dir == "." then
				return filename
			end

			local display = dir .. "/" .. filename
			local highlights = {
				{
					{ 0, #dir + 1 },
					"Comment",
				},
			}

			return display, highlights
		end,
	}
end

return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	lazy = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"nvim-telescope/telescope-media-files.nvim",
		"nvim-telescope/telescope-live-grep-args.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
	},
	cmd = "Telescope",
	keys = {
		{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
		{
			"<leader>faf",
			function()
				require("telescope.builtin").find_files(alx_telescope_config("Find ALX files"))
			end,
			desc = "Find ALX files",
		},
		{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
		{
			"<leader>fag",
			function()
				require("telescope").extensions.live_grep_args.live_grep_args(alx_telescope_config("ALX live grep"))
			end,
			desc = "ALX live grep",
		},
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
				prompt_prefix = "",
				selection_caret = "➜ ",
				path_display = { "filename_first" },
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
					width = 0.95,
					height = 0.95,
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
		telescope.load_extension("live_grep_args")
	end,
}
