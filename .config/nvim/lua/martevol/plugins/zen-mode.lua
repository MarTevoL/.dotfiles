-- Lua
return {
  "Snikimonkd/yazmp",
  config = function()
    require("lazy").setup({
      "Snikimonkd/yazmp",
    })
    vim.keymap.set({ "n", "v" }, "<leader>Z", ":Zenmode 50<Cr>")
  end,
}
