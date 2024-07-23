return {
  "akinsho/bufferline.nvim",
  version = "*",
  enabled = false,
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    vim.opt.termguicolors = true
    local bufferline = require("bufferline")
    bufferline.setup({
      options = {
        style_preset = {
          bufferline.style_preset.no_italic,
          bufferline.style_preset.no_bold,
        },
        mode = "buffers",
        themable = true,
        offsets = {
          filetype = "NvimTree",
          text = "File Explorer",
          separator = true,
        },
        -- indicator = {
        --   icon = "▎", -- this should be omitted if indicator style is not 'icon'
        --   style = "icon",
        -- },
        -- color_icons = true,
        -- show_buffer_icons = true,
        -- persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
        -- sort_by = "insert_after_current",
      },
    })
  end,
}
