local function find_venv(path)
	local possible_env_names = {}
	possible_env_names[1] = "/.env"
	possible_env_names[2] = "/.venv"
	possible_env_names[3] = "/env"
	possible_env_names[4] = "/venv"

	for _, v in ipairs(possible_env_names) do
		local possible_path = path .. v
		if vim.fn.isdirectory(possible_path) == 1 then
			vim.notify("Found python environment: " .. possible_path)
			return possible_path
		end
	end
	vim.notify("Python environment not found!")
end

local pyright_restarted = false

local function pyright_on_init()
	if not pyright_restarted then
		local cwd = vim.fn.getcwd()
		local current_venv = find_venv(cwd)
		if current_venv then
			vim.fn.setenv("VIRTUAL_ENV", current_venv)

			vim.schedule(function()
				vim.cmd("LspRestart pyright")
				vim.notify("Lsp pyright restarted")
				pyright_restarted = true
			end)
		end
	end
	return true
end

return {
	"williamboman/mason-lspconfig.nvim",
	dependencies = { "mason.nvim", "hrsh7th/nvim-cmp" },

	config = function()
		local mason_lspconfig = require("mason-lspconfig")
		mason_lspconfig.setup({})

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

			["svelte"] = function()
				lspconfig["svelte"].setup({
					capabilities = capabilities,
					on_attach = function(client, _)
						vim.api.nvim_create_autocmd("BufWritePost", {
							pattern = { "*.js", "*.ts" },
							callback = function(ctx)
								-- Here use ctx.match instead of ctx.file
								client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
							end,
						})
					end,
				})
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
