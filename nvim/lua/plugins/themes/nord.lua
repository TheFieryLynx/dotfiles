return {
  "shaunsingh/nord.nvim",
  priority = 1000,
  config = function()
    local user_settings = require("user-settings")

    local theme = require("user-settings").theme
    local sys_params = require("system-params")
    vim.g.nord_disable_background = user_settings.transparent_background
    vim.g.nord_italic = false
    vim.opt.termguicolors = true

    if theme == sys_params.available_themes.nord then
      vim.cmd([[colorscheme nord]])
    end
  end,
}
