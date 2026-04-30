vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

opt.swapfile = false
opt.cursorline = true
opt.termguicolors = true
opt.tabstop = 2
opt.expandtab = true
opt.shiftwidth = 2
opt.guicursor = "a:ver100"
opt.clipboard = "unnamedplus"
opt.ignorecase = true
opt.smartcase = true
opt.signcolumn = "yes"

vim.wo.scrolloff = 5

vim.diagnostic.config({
	virtual_text = false,
})

vim.wo.number = true
vim.g.mapleader = " "

vim.g.yuck_lisp_indentation = 1
vim.g.yuck_align_subforms = 1
vim.g.yuck_align_multiline_strings = 1

vim.cmd("set selection=exclusive")
vim.o.virtualedit = "onemore"

vim.o.updatetime = 100

vim.api.nvim_create_autocmd("CursorHold", {
	group = vim.api.nvim_create_augroup("FloatDiagnostics", { clear = true }),
	callback = function()
		vim.diagnostic.open_float(nil, {
			focus = false,
			border = "rounded",
			scope = "cursor",
		})
	end,
})

vim.filetype.add({
	pattern = {
		[".*%.ya?ml"] = function(path, bufnr)
			-- читаем первую строку файла (или буфера)
			local line1 = vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)[1] or ""
			if line1:match("^%-%-%-") then
				return "yaml.ansible"
			end
			return "yaml"
		end,
	},
})
vim.filetype.add({
	pattern = {
		[".*%.j2"] = "jinja",
	},
})
vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
	pattern = { "*.yml", "*.yaml" },
	callback = function(args)
		local buf = args.buf
		local line1 = vim.api.nvim_buf_get_lines(buf, 0, 1, false)[1] or ""
		local wants_ansible = line1:match("^%-%-%-") ~= nil

		local ft = vim.bo[buf].filetype
		if wants_ansible and ft == "yaml" then
			vim.bo[buf].filetype = "yaml.ansible"
		elseif (not wants_ansible) and ft == "yaml.ansible" then
			vim.bo[buf].filetype = "yaml"
		end
	end,
})
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = { "*.yml", "*.yaml" },
	callback = function(args)
		-- если filetype уже не yaml — не трогаем
		if vim.bo[args.buf].filetype ~= "yaml" then
			return
		end

		local first_line = vim.fn.getline(1)
		if first_line:match("^%-%-%-") then
			vim.bo[args.buf].filetype = "yaml.ansible"
		end
	end,
})
