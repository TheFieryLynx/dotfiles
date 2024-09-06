return {
  "nvim-tree/nvim-tree.lua",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    local nvtree = require("nvim-tree")

    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    vim.g.nvim_tree_ignore = { ".git", "node_modules", ".cache" }

    nvtree.setup({
      view = {
        width = 35,
        relativenumber = true,
      },
      git = {
        enable = true,
        ignore = false,
        timeout = 500,
      },
      filters = {
        custom = {
          ".git",
          ".idea",
          ".DS_Store",
          ".ruff_cache",
          "__pycache__",
        },
      },
    })
    -- set keymaps

    require("which-key").register({
      ["<leader>e"] = { "<cmd>NvimTreeToggle<CR>", "Toggle file explorer" },
    })

    require("which-key").register({
      ["<leader>ef"] = { "<cmd>NvimTreeFocus<CR>", "Focus file explorer" },
    })
  end,
}
