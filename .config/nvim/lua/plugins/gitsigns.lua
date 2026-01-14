return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local gitsigns = require("gitsigns")
		gitsigns.setup({
			signs = {
				add = { text = "┃" },
				change = { text = "┃" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
				untracked = { text = "┆" },
			},
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = "eol",
				delay = 500,
				ignore_whitespace = true,
				virt_text_priority = 100,
				use_focus = true,
			},
			current_line_blame = true,
			signcolumn = true,
		})

		require("which-key").register({
			["<leader>td"] = { gitsigns.preview_hunk_inline, "Toggle deleted" },
		})
	end,
}
