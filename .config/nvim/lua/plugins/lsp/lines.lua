return {
  "https://github.com/maan2003/lsp_lines.nvim",
  config = function()
    local lsp_lines = require("lsp_lines")

    lsp_lines.setup({})

    vim.keymap.set("", "<Leader>l", require("lsp_lines").toggle, { desc = "Toggle lsp_lines" })
  end,
}
