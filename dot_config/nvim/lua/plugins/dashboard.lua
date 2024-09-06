return {
  "nvimdev/dashboard-nvim",
  dependencies = {
    "MaximilianLloyd/ascii.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
  },
  event = "VimEnter",
  config = function()
    require("dashboard").setup({
      theme = "doom",
      config = {
        packages = { enable = true },
        header = require("user-settings").dashboard_header,
        center = {
          {
            icon = " ",
            icon_hl = "Title",
            desc = "Find files",
            key = "space",
            keymap = "<leader>",
            key_format = " %s",
          },
          {
            icon = " ",
            icon_hl = "Title",
            desc = "Browse files",
            key = "e",
            keymap = "<leader>",
            key_format = " %s",
          },
        },
      },
    })
  end,
}
