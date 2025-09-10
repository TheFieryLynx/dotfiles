return {
  "christoomey/vim-tmux-navigator",
  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
    "TmuxNavigatePrevious",
  },
  keys = {
    { "<M-j>", "<cmd>TmuxNavigateLeft<cr>" },
    { "<M-k>", "<cmd>TmuxNavigateDown<cr>" },
    { "<M-i>", "<cmd>TmuxNavigateUp<cr>" },
    { "<M-l>", "<cmd>TmuxNavigateRight<cr>" },
  },
}
