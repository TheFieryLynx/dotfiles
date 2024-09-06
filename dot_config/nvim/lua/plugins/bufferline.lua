return {
  "akinsho/bufferline.nvim",
  config = function()
    vim.opt.termguicolors = true
    local highlights

    local user_settings = require("user-settings")
    local sys_params = require("system-params")

    if user_settings.theme == sys_params.available_themes.nord then
      highlights = require("nord").bufferline.highlights({
        italic = false,
        bold = true,
        fill = "#181c24",
        buffer_bg = "#000000",
      })
    end

    if user_settings.theme == sys_params.available_themes.catppuccin then
      highlights = require("catppuccin.groups.integrations.bufferline").get()
    end

    local buffer = require("bufferline")
    buffer.setup({
      options = {
        separator_style = "thin",
        highlights = highlights,
        offsets = {
          {
            filetype = "NvimTree",
            text = "Nvim Tree",
            separator = true,
            text_align = "left",
          },
        },
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          return "(" .. count .. ")"
        end,
        modified_icon = "●",
        show_close_icon = true,
        close_icon = "󰅖",
        show_buffer_close_icons = true,
      },
    })
    vim.keymap.set("n", "<Tab>", "<cmd> BufferLineCycleNext <CR>", { desc = "Buffer next" })
    vim.keymap.set("n", "<S-Tab>", "<cmd>  BufferLineCyclePrev <CR>", { desc = "Buffer prev" })
    vim.keymap.set("n", "<leader>w", "<cmd> bp|sp|bn|bd! <CR>", { desc = "Buffer close" })
  end,
}
