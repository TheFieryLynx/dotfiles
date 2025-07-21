return {
	"mason-org/mason-lspconfig.nvim",
	dependencies = { "mason-org/mason.nvim", "hrsh7th/nvim-cmp" },
	enabled = false,
	config = function()
		local mason_lspconfig = require("mason-lspconfig")
		mason_lspconfig.setup({
			ensure_installed = {
				"pyright",
				"ruff",
			},
		})

		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		local lspconfig = require("lspconfig")

		require("mason-lspconfig").setup_handlers({
			function(server_name)
				require("lspconfig")[server_name].setup({})
			end,

			["ansiblels"] = function()
				lspconfig.ansiblels.setup({
					filetypes = { "yaml", "yml" },
					capabilities = capabilities,
				})
			end,

			["pyright"] = function()
				lspconfig.pyright.setup({
					-- capabilities = capablities,
					filetypes = { "python" },
					settings = {
						python = {
							analysis = {
								useLibraryCodeForTypes = "True",
								diagnosticSeverityOverrides = {
									reportIncompatibleVariableOverride = "none",
								},
							},
						},
					},
				})
			end,

			["lua_ls"] = function()
				lspconfig.lua_ls.setup({
					capabilities = capabilities,
					settings = {
						Lua = {
							diagnostics = {
								globals = { "vim" },
							},
						},
					},
				})
			end,

			["eslint"] = function()
				lspconfig.eslint.setup({
					capabilities = capabilities,
					on_attach = function(_, bufnr)
						vim.api.nvim_create_autocmd("BufWritePre", {
							buffer = bufnr,
							command = "EslintFixAll",
						})
					end,
				})
			end,
		})
	end,
}
