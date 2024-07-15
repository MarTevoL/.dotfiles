return {
  "stevearc/oil.nvim",
  opts = {},
  -- Optional dependencies
  dependencies = { "echasnovski/mini.icons" },
  -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
  config = function()
    require("oil").setup({
      default_file_explorer = true,
      columns = { "icon" },
      view_options = {
        show_hidden = true,
      },
    })
    -- Open parent directory in current window
    vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

    -- Open parent directory in floating window
    vim.keymap.set("n", "<space>-", require("oil").toggle_float)
  end,
}
