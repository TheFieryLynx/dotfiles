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
		local diagnostics_maker = require("telescope.make_entry").gen_from_diagnostics({})
		local entry_display = require("telescope.pickers.entry_display")
		local diag_displayer = entry_display.create({
			separator = " ",
			items = {
				{ width = 20 }, -- файл
				{ width = 8 }, -- позиция
				{ remaining = true }, -- сообщение
			},
		})
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
				hidden = true,
				no_ignore = true,
				file_ignore_patterns = {
					"^%.git/",
					"^%.cache/",
					"^%.local/",
					"^%.npm/",
					"^%.cargo/",
					"^%.venv/",
					"^%.env/",
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
			pickers = {
				find_files = { hidden = true, no_ignore = true },
				diagnostics = {
					layout_strategy = "vertical",
					layout_config = {
						width = 0.9,
						height = 0.95,
						preview_height = 0.6,
					},
					entry_maker = function(entry)
						-- базовый item как делает сам Telescope
						local item = diagnostics_maker(entry)

						-- короткое имя файла (без пути)
						local short = ""
						if item.filename and item.filename ~= "" then
							short = vim.fn.fnamemodify(item.filename, ":t")
						end

						-- текст сообщения (в одну строку)
						local msg = item.text or item.value or ""
						msg = msg:gsub("\n", " "):gsub("%s+", " ")

						-- позиция
						local pos = string.format("%d:%d", item.lnum or 0, item.col or 0)

						-- display теперь функция, которая возвращает текст + хайлайты
						item.display = function(entry_inner)
							return diag_displayer({
								{ short, "Directory" }, -- имя файла с цветом
								{ pos, "LineNr" }, -- позиция
								{ msg }, -- сообщение
							})
						end

						return item
					end,
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
