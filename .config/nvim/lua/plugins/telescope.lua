return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"duane9/nvim-rg",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
	},
	config = function()
		local telescope = require("telescope")
		local telescope_builtin = require("telescope.builtin")
		local wk = require("which-key")

		telescope.setup({
			defaults = {
				path_display = { "smart" },
				layout_strategy = "horizontal",
				layout_config = {
					horizontal = {
						width = 0.95,
						height = 0.95,
						preview_width = 0.65,
					},
				},
				wrap_results = true,
				prompt_title = false,
				results_title = false,
				sorting_strategy = "descending",
				dynamic_preview_title = true,
				vimgrep_arguments = {
					"rg",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
					"--fixed-strings",
				},
			},
			extensions = {
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
			},
		})
		pcall(telescope.load_extension, "fzf")

		wk.register({
			["<leader><Space>"] = { telescope_builtin.find_files, "Search files" },
			["<leader>fg"] = { telescope_builtin.live_grep, "Grep all files" },
			["<leader>fb"] = { telescope_builtin.buffers, "Search buffers" },
			["<leader>fh"] = { telescope_builtin.help_tags, "Search help tags" },
		})
		vim.api.nvim_create_autocmd("User", {
			pattern = "TelescopePreviewerLoaded",
			callback = function(args)
				local bufnr = args.buf
				local win = vim.fn.bufwinid(bufnr)
				if win ~= -1 then
					vim.wo[win].number = true
					vim.wo[win].relativenumber = false
					vim.wo[win].wrap = false
					vim.wo[win].cursorline = true
				end
			end,
		})
	end,
}
