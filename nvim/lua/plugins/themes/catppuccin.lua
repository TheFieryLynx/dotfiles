return {
  "catppuccin/nvim",
  priority = 1000,
  config = function()
    local user_settings = require("user-settings")

    local theme = require("user-settings").theme
    local sys_params = require("system-params")
    require("catppuccin").setup({
      custom_highlights = function(colors)
        return {
          IlluminatedWordRead = { bg = colors.surface2 },
        }
      end,
      flavour = "macchiato",
      transparent_background = user_settings.transparent_background,
      default_integrations = true,
      integrations = {
        nvimtree = true,
        mason = true,
        notify = true,
        dashboard = true,
        treesitter = true,
        which_key = true,
        illuminate = {
          enabled = true,
          lsp = true,
        },
      },
    })

    if theme == sys_params.available_themes.catppuccin then
      vim.cmd([[colorscheme catppuccin]])
    end
  end,
}
