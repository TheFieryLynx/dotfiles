return {
	"LuxVim/nvim-luxmotion",
	config = function()
		local luxmotion = require("luxmotion")
		luxmotion.setup({
			cursor = {
				duration = 250,
				easing = "ease-out",
				enabled = true,
			},
			scroll = {
				duration = 400,
				easing = "ease-out",
				enabled = true,
			},
			performance = { enabled = false },
			keymaps = {
				cursor = true,
				scroll = true,
			},
		})
		luxmotion.enable()
	end,
}
