return {
  "numToStr/Comment.nvim",
  config = function()
    local comment = require("Comment")
    comment.setup({
      padding = true,
      sticky = true,
    })

    vim.keymap.set("v", "<leader>cc", "<Plug>(comment_toggle_linewise_visual)", { desc = "Comment visual lines" })
    vim.keymap.set("v", "<leader>cb", "<Plug>(comment_toggle_blockwise_visual)", { desc = "Comment visual block" })

    vim.keymap.set("n", "<leader>cb", "<Plug>(comment_toggle_blockwise_current)", { desc = "Comment line block" })
    vim.keymap.set("n", "<leader>cc", "<Plug>(comment_toggle_linewise_current)", { desc = "Comment line current" })
  end,
}
