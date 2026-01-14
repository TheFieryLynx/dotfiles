return {
	"folke/trouble.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim",
	},
	opts = {},
	cmd = "Trouble",
	keys = {
		{
			"<leader>xx",
			function()
				require("telescope.builtin").diagnostics()
			end,
			desc = "Diagnostics (Telescope)",
		},
		{
			"<leader>cs",
			function()
				require("telescope.builtin").lsp_document_symbols({ symbols = { "Function", "Method" } })
			end,
			desc = "Symbols (Telescope)",
		},
	},
}
