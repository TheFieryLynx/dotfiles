return {
  "akinsho/flutter-tools.nvim",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "stevearc/dressing.nvim",
  },
  config = function()
    require("flutter-tools").setup({
      flutter_path = "/home/andrew/software/flutter/bin/flutter",
      lsp = {
        color = {
          enabled = true,
        },
      },
    })

    vim.keymap.set("n", "fl", require("telescope").extensions.flutter.commands, { desc = "Open command Flutter" })
  end,
}
