return {
  "stevearc/oil.nvim",
  opts = {},
  -- Optional dependencies
  dependencies = { "echasnovski/mini.icons" },
  -- keys = {
  --   {
  --     "<leader>sf",
  --     function()
  --       require("oil").toggle_float()
  --       vim.api.nvim_buf_set_keymap(0, "n", "<Esc>", "<CMD>lua require('oil').close()<CR>", { silent = true })
  --     end,
  --     desc = "Oil open float",
  --     silent = true,
  --   },
  -- }, -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
  config = function()
    require("oil").setup({
      default_file_explorer = true,
      columns = { "icon" },
      view_options = {
        show_hidden = true,
      },
    })
    -- Open parent directory in current window
    vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Oil open parent directory" })
  end,
}
