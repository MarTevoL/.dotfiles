return {
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "+" },
          change = { text = "~" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
        },
      })

      local keymap = vim.keymap
      keymap.set("n", "<leader>hp", ":Gitsigns preview_hunk<CR>", {})
    end,
  },
}
