return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "duane9/nvim-rg" },
  config = function()
    local telescope = require("telescope")
    local telescope_builtin = require("telescope.builtin")

    require("telescope").load_extension("flutter")

    require("which-key").register({
      ["<leader><Space>"] = { telescope_builtin.find_files, "Search files" },
    })

    require("which-key").register({
      ["<leader>fg"] = { telescope_builtin.live_grep, "Grep all files" },
    })

    require("which-key").register({
      ["<leader>fb"] = { telescope_builtin.buffers, "Search buffers" },
    })

    require("which-key").register({
      ["<leader>fh"] = { telescope_builtin.help_tags, "Search help tags" },
    })
  end,
}
