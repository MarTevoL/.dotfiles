-- Custom Parameters (with defaults)
return {
  "David-Kunz/gen.nvim",

  config = function()
    require("gen").setup({
      model = "deepseek-r1", -- The default model to use.
      quit_map = "q", -- set keymap for close the response window
      display_mode = "split", -- The display mode. Can be "float" or "split" or "horizontal-split".
      show_model = true, -- Displays which model you are using at the beginning of your chat session.
      vim.keymap.set({ "n", "v" }, "<leader>G", ":Gen"),
      vim.keymap.set({ "n", "v" }, "<leader>Gg", function()
        require("gen").select_model()
      end),
    })
  end,
}
