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
			automatic_enable = false,
		})

		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN] = " ",
					[vim.diagnostic.severity.HINT] = "󰠠 ",
					[vim.diagnostic.severity.INFO] = " ",
				},
				texthl = {
					[vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
					[vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
					[vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
					[vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
				},
				numhl = {
					[vim.diagnostic.severity.ERROR] = "",
					[vim.diagnostic.severity.WARN] = "",
					[vim.diagnostic.severity.HINT] = "",
					[vim.diagnostic.severity.INFO] = "",
				},
			},
		})

		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		vim.lsp.enable({ "pyright", "lua_ls", "qmlls" })

		vim.lsp.config["pyright"] = {
			capabilities = capabilities,
			filetypes = { "python" },
			settings = {
				python = {
					analysis = {
						useLibraryCodeForTypes = "True",
						diagnosticSeverityOverrides = {
							reportIncompatibleVariableOverride = "none",
							reportGeneralTypeIssues = "none",
						},
					},
				},
			},
		}
		vim.lsp.config["qmlls"] = {
			capabilities = capabilities,
			settings = {
				root_dir = vim.lsp.util.find_git_ancestor,
				qmlls = {
					builDir = "build",
					qmlDir = "/usr/lib/qt6/qml",
				},
			},
		}
		vim.lsp.config["lua_ls"] = {
			capabilities = capabilities,
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
				},
			},
		}
	end,
}
