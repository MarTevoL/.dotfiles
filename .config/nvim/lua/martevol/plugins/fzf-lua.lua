-- Picker, finder, etc.
return {
  {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    keys = {
      { "<leader>f<", "<cmd>FzfLua resume<cr>", desc = "Resume last command" },
      -- {
      --   "<leader>fb",
      --   function()
      --     require("fzf-lua").lgrep_curbuf({
      --       winopts = {
      --         height = 0.8,
      --         width = 0.8,
      --         preview = { vertical = "up:70%" },
      --       },
      --     })
      --   end,
      --   desc = "Fzf Grep current buffer",
      -- },
      { "<leader>fc", "<cmd>FzfLua highlights<cr>", desc = "Highlights" },
      -- { "<leader>fr", "<cmd>FzfLua lsp_references<cr>", desc = "Show references" },
      { "<leader>fi", "<cmd>FzfLua lsp_implementations<cr>", desc = "Show implementations" },
      { "<leader>fd", "<cmd>FzfLua lsp_document_diagnostics<cr>", desc = "Document diagnostics" },
      { "<leader>fD", "<cmd>FzfLua lsp_workspace_diagnostics<cr>", desc = "Workspace diagnostics" },
      -- { "<leader>ff", "<cmd>FzfLua files<cr>", desc = "FzF Find files" },
      -- { "<leader>fg", "<cmd>FzfLua live_grep<cr>", desc = "Fzf Grep" },
      -- { "<leader>fv", "<cmd>FzfLua grep_visual<cr>", desc = "Fzf Grep current select word", mode = "x" },
      -- { "<leader>fl", "<cmd>FzfLua grep_last<cr>", desc = "Fzf Grep last" },
      -- { "<leader>fh", "<cmd>FzfLua help_tags<cr>", desc = "Help" },
    },
    config = function()
      require("fzf-lua").setup({ { "telescope", "fzf-native" }, winopts = { preview = { default = "bat" } } })
    end,
  },
}
