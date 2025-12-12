return {
	{
		"NStefan002/screenkey.nvim",
		lazy = false,
		commit = "ffe868e737d16d07a9792c8e04568cf8a2644cb7",
		config = function()
			require("screenkey").setup({
				filter = function(keys)
					local screenkey = require("screenkey")
					for i, k in ipairs(keys) do
						if screenkey.statusline_component_is_active() and k.key == "%" then
							keys[i].key = "%%"
						end
					end
					return keys
				end,
				disable = { modes = { "i", "t" } },
				show_leader = false,
				separator = "",
				hl_groups = {
					["screenkey.hl.key"] = { link = "DiffAdd" },
					["screenkey.hl.map"] = { link = "DiffDelete" },
					["screenkey.hl.sep"] = { bg = "red", fg = "blue" },
				},
			})
			vim.g.screenkey_statusline_component = true

			vim.keymap.set("n", "<leader>ts", function()
				require("screenkey").toggle_statusline_component()
			end, { desc = "Toggle screenkey statusline component" })
			require("screenkey").toggle_statusline_component()
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = {
					globalstatus = true,
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch" },
					lualine_c = {
						"filename",
						{
							"diagnostics",
							sources = { "nvim_lsp" },
						},
					},
					lualine_x = {
						function()
							return require("screenkey").get_keys()
						end,
						{
							function()
								local buf_clients = vim.lsp.get_clients({ bufnr = 0 })
								if #buf_clients == 0 then
									return "LSP Inactive"
								end
								return buf_clients[1].name
							end,
							icon = " ",
						},
						"encoding",
						"fileformat",
						"filetype",
					},
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
			})
		end,
	},
}
