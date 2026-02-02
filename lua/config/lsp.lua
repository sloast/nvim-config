----------------
---- Python ----
----------------

vim.lsp.config("pyright", {
	settings = {
		python = {
			analysis = {
				typeCheckingMode = "normal",
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
			},
		},
		pyright = {
			disableOrganizeImports = true,
		},
	},
})

vim.lsp.config("ruff", {
	-- init_options = {
	-- 	settings = {
	-- 	},
	-- },
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

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client == nil then
			return
		end
		if client.name == "ruff" then
			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*.py",
				callback = function()
					-- Organize imports
					vim.lsp.buf.code_action({
						context = {
							only = { "source.organizeImports" },
							diagnostics = {},
						},
						apply = true,
					})

					-- Fix all auto-fixable issues
					vim.lsp.buf.code_action({
						context = {
							only = { "source.fixAll" },
							diagnostics = {},
						},
						apply = true,
					})

					-- Format
					vim.lsp.buf.format({ async = false })
				end,
			})
		end
	end,
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

--vim.lsp.enable("yamlls")
vim.lsp.enable("helm_ls")

----------------------------
---- TypeScript/Angular ----
----------------------------

vim.lsp.config("ts_ls", {
	init_options = {
		plugins = {
			{
				name = "@angular/language-server",
				location = vim.fn.stdpath("data") .. "/mason/packages/angular-language-server/node_modules/@angular/language-server",
			},
		},
	},
	filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "html" },
})

vim.lsp.config("angularls", {
	root_markers = { "angular.json" },
})

vim.lsp.enable("ts_ls")
vim.lsp.enable("angularls")

----------------
---- Java ------
----------------

vim.lsp.config("jdtls", {
	root_markers = { "pom.xml", "build.gradle", "gradlew", ".git" },
})

vim.lsp.enable("jdtls")

--------------------
------ Other -------
--------------------

vim.lsp.enable("bashls")
vim.lsp.enable("fish_lsp")
vim.lsp.enable("lua_ls")
vim.lsp.enable("fennel_ls")
vim.lsp.enable("rust_analyzer")

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
