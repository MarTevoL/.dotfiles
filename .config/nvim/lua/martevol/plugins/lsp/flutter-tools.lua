return {
  {
    "akinsho/flutter-tools.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim",
    },
    config = function()
      require("flutter-tools").setup({
        decorations = {
          statusline = {
            app_version = true,
            device = true,
          },
        },
        dev_tools = {
          autostart = true, -- autostart devtools server if not detected
          auto_open_browser = true, -- Automatically opens devtools in the browser
        },
        lsp = {
          color = { -- show the derived colours for dart variables
            enabled = true, -- whether or not to highlight color variables at all, only supported on flutter >= 2.10
            background = false, -- highlight the background
            background_color = nil, -- required, when background is transparent (i.e. background_color = { r = 19, g = 17, b = 24},)
            foreground = false, -- highlight the foreground
            virtual_text = true, -- show the highlight using virtual text
            virtual_text_str = "■", -- the virtual text character to highlight
          },
        },
        debugger = { -- integrate with nvim dap + install dart code debugger
          enabled = true,
        },
      })
    end,
  },
  {
    "wa11breaker/dart-data-class-generator.nvim",
    dependencies = {
      "nvimtools/none-ls.nvim",
    },
    ft = "dart",
    config = function()
      require("dart-data-class-generator").setup({})
    end,
  },
}
