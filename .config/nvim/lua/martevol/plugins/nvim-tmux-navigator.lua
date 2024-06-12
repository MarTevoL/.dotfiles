return {
  "nvim-lua/plenary.nvim", -- lua functions that many plugins use
  "christoomey/vim-tmux-navigator",
  vim.keymap.set("n", "C-h", ":TmuxNavigateLeft<CR>"),
  vim.keymap.set("n", "C-j", ":TmuxNavigateDown<CR>"),
  vim.keymap.set("n", "C-k", ":TmuxNavigateUp<CR>"),
  vim.keymap.set("n", "C-l", ":TmuxNavigateRight<CR>"),
}
