return {
  "wa11breaker/flutter-bloc.nvim",
  config = function()
    vim.keymap.set(
      "n",
      "<Leader>cfb",
      "<cmd>lua require('flutter-bloc').create_bloc()<cr>",
      { desc = "[C]reate [F]lutter [B]loc" }
    )
    vim.keymap.set(
      "n",
      "<Leader>cfc",
      "<cmd>lua require('flutter-bloc').create_cubit()<cr>",
      { desc = "[C]reate [F]lutter [C]ubit" }
    )
  end,
}
