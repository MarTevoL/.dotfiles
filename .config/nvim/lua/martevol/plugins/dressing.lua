return {
  "stevearc/dressing.nvim",
  event = "VeryLazy",
  config = function()
    require("dressing").setup({
      select = {
        get_config = function(opts)
          if opts.kind == "codeaction" then
            return {
              backend = "fzf",
              fzf = {
                window = {
                  width = 0.5,
                  height = 0.5,
                },
              },
              -- fzf_lua = {
              --   winopts = {
              --     height = 0.5,
              --     width = 0.5,
              --   },
              -- },
              -- nui = {
              --   relative = "editor",
              --   max_width = 40,
              -- },
            }
          end
        end,
      },
    })
  end,
}
