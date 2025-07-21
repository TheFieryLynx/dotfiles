return {
	"mason-org/mason-lspconfig.nvim",
	opts = {},
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
		"neovim/nvim-lspconfig",
	},
	enabled = true,
	config = function()
		local mason_lspconfig = require("mason-lspconfig")
		mason_lspconfig.setup({
			ensure_installed = {
				"pyright",
				"lua_ls",
				"qmlls",
			},
		})

		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		local lspconfig = require("lspconfig")

		lspconfig.ansiblels.setup({
			filetypes = { "yaml", "yml" },
			capabilities = capabilities,
		})
		lspconfig.qmlls.setup({
			filetypes = { "qml" },
			capabilities = capabilities,
			cmd = { "qmlls" },
		})

		lspconfig.pyright.setup({
			capabilities = capabilities,
			filetypes = { "python" },
			settings = {
				python = {
					analysis = {
						useLibraryCodeForTypes = true,
						diagnosticSeverityOverrides = {
							reportIncompatibleVariableOverride = "none",
						},
					},
				},
			},
		})

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
}
