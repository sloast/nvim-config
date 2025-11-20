----------------
---- Python ----
----------------

vim.lsp.config("pyright", {
	settings = {
		python = {
			analysis = {
				typeCheckingMode = "strict",
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
			},
		},
	},
})

vim.lsp.config("ruff", {
	--   init_options = {
	--     settings = {
	--       -- Ruff language server settings go here
	--     }
	--   }
})

vim.lsp.enable("pyright")
vim.lsp.enable("ruff")

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp_attach_disable_ruff_hover", { clear = true }),
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client == nil then
			return
		end
		if client.name == "ruff" then
			-- Disable hover in favor of Pyright
			client.server_capabilities.hoverProvider = false
		end
	end,
	desc = "LSP: Disable hover capability from Ruff",
})

-- -- Enable LSP for filetypes
-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = "python",
-- 	callback = function()
-- 		vim.lsp.enable("pyright")
-- 		vim.lsp.enable("ruff")
-- 	end,
-- })

-- Auto-format on save
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.py",
	callback = function()
		vim.lsp.buf.format()
	end,
})

------------------------
--------- YAML ---------
------------------------

vim.lsp.config("helm_ls", {
	cmd = { "helm_ls", "serve" },
	root_markers = { "Chart.yaml" },
	filetypes = { "helm" },
	settings = {
		["helm-ls"] = {
			yamlls = {
				path = "yaml-language-server",
			},
		},
	},
})

vim.lsp.enable("yamlls")
vim.lsp.enable("helm_ls")

--------------------
------ Other -------
--------------------

vim.lsp.enable("bashls")
vim.lsp.enable("fish_lsp")
vim.lsp.enable("lua_ls")
vim.lsp.enable("fennel_ls")

---------------------
---- Diagnostics ----
---------------------

vim.diagnostic.config({
	virtual_text = {
		enabled = true,
		source = "if_many",
		spacing = 4,
		severity = {
			min = vim.diagnostic.severity.HINT,
		},
	},
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "!",
			[vim.diagnostic.severity.WARN] = "?",
			[vim.diagnostic.severity.INFO] = "i",
			[vim.diagnostic.severity.HINT] = "h",
		},
	},
})
