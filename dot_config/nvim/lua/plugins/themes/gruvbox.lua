return {
  "ellisonleao/gruvbox.nvim",
  priority = 1000,
  config = function()
    local user_settings = require("user-settings")

    local theme = require("user-settings").theme
    local sys_params = require("system-params")

    require("gruvbox").setup({
      terminal_colors = true,
      undercurl = true,
      underline = true,
      bold = true,
      italic = {
        strings = false,
        emphasis = true,
        comments = true,
        operators = false,
        folds = false,
      },
      strikethrough = true,
      invert_selection = false,
      invert_signs = false,
      invert_tabline = false,
      invert_intend_guides = false,
      inverse = true,
      contrast = "hard",
      palette_overrides = {},
      overrides = {},
      dim_inactive = false,
      transparent_mode = user_settings.transparent_background,
    })

    if theme == sys_params.available_themes.gruvbox then
      vim.cmd([[colorscheme gruvbox]])
    end
  end,
}
