return {
  "catppuccin/nvim",
  lazy = false,
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      integrations = {
        cmp = true,
        nvimtree = true,
        treesitter = true,
        leap = true,
      },
    })
    vim.cmd.colorscheme("catppuccin")
  end,
}