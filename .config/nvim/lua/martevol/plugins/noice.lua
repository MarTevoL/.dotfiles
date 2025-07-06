return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    presets = {
      lsp_doc_border = true,
    },
  },

  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    "MunifTanjim/nui.nvim",
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    "rcarriga/nvim-notify",
  },

  config = function()
    require("noice").setup({
      routes = {
        {
          filter = { event = "notify", find = "No information available" },
          opts = { skip = true },
        },
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "; after #%d+" },
              { find = "; before #%d+" },
              { find = "fewer lines" },
              { find = "written" },
              { find = "Conflict %[%d+" },
              { find = "Col %d+" },
              { find = "Resolving dependencies" },
            },
          },
          view = "mini",
        },
        {
          filter = {
            event = "notify",
            min_height = 15,
          },
          view = "split",
        },
      },
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          -- override the default lsp markdown formatter with Noice
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          -- override the lsp markdown formatter with Noice
          ["vim.lsp.util.stylize_markdown"] = true,
          -- override cmp documentation with Noice (needs the other options to work)
          ["cmp.entry.get_documentation"] = true,
        },
        hover = { enabled = false }, -- <-- HERE!
        signature = { enabled = false }, -- <-- HERE!
      },
    })
    -- See: https://github.com/folke/noice.nvim/issues/258
    require("noice.lsp").hover()
    -- See: https://github.com/NvChad/NvChad/issues/1656
    -- vim.notify = require("noice").notify
    -- vim.lsp.handlers["textDocument/hover"] = require("noice").hover
    -- vim.lsp.handlers["textDocument/signatureHelp"] = require("noice").signature
  end,
}
