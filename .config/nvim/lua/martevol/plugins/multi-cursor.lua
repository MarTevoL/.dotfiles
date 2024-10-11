return {
  "mg979/vim-visual-multi",
  config = function()
    vim.g.VM_default_mappings = 0
    vim.g.VM_default_map = {
      ["Find Under"] = "",
    }
    vim.g.VM_add_cursor_at_pos_no_mappings = 1

    vim.keymap.set("n", "<C-x>", "<Plug>(VM-Find-Under)")
    vim.keymap.set("n", "<C-m>", "<Plug>(VM-Add-Cursor-At-Pos)")
    vim.keymap.set("n", "<leader>vj", "<Plug>(VM-Add-Cursor-Down)")
    vim.keymap.set("n", "<leader>vm", "<Plug>(VM-Toggle-Mappings)")
  end,
}
