return {
  "williamboman/mason.nvim",
  opts = {
    ensure_installed = {
      "pyright",
    },
  },
  config = function()
    local mason = require("mason")
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })
  end,
}
