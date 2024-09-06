vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

opt.swapfile = false
opt.ignorecase = true
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
