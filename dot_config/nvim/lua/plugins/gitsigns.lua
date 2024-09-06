return {
  "lewis6991/gitsigns.nvim",
  config = function()
    local gitsigns = require("gitsigns")
    gitsigns.setup({
      on_attach = function(bufnr)
        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "]c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gitsigns.nav_hunk("next")
          end
        end)

        map("n", "[c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gitsigns.nav_hunk("prev")
          end
        end)

        -- Actions
        map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Stage the hunk at the cursor position" })
        map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Reset the lines of the hunk at the cursor position" })
        map("v", "<leader>hs", function()
          gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = "Stage the hunk at all lines in the given range" })
        map("v", "<leader>hr", function()
          gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = "Reset the lines of all lines in the given range" })
        map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Stage all hunks in current buffer" })
        map("n", "<leader>hu", gitsigns.undo_stage_hunk, { desc = "Unstage all hunks in current buffer" })
        map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Reset the lines of all hunks in the buffer." })
        map(
          "n",
          "<leader>hp",
          gitsigns.preview_hunk,
          { desc = "Preview the hunk at the cursor position in a floating window" }
        )
        map("n", "<leader>hb", function()
          gitsigns.blame_line({ full = true })
        end, { desc = "Run git blame on the current line and show the results in a floating window." })
        map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "" })
        map("n", "<leader>hd", gitsigns.diffthis, { desc = "Perform a vimdiff on the given file" })
        map("n", "<leader>hD", function()
          gitsigns.diffthis("~")
        end, { desc = "" })
        map("n", "<leader>td", gitsigns.toggle_deleted, { desc = "" })

        -- Text object
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
      end,
    })
  end,
}
