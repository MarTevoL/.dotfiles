return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = false,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    require("obsidian").setup({
      workspaces = {
        {
          name = "MartVault",
          path = "/Users/truongle/Library/Mobile Documents/iCloud~md~obsidian/Documents/MartVault",
        },
      },
      notes_subdir = "inbox",
      new_notes_location = "notes_subdir",

      disable_frontmatter = true,
      templates = {
        subdir = "templates",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M:%S",
      },

      -- name new notes starting the ISO datetime and ending with note name
      -- put them in the inbox subdir
      -- note_id_func = function(title)
      --   local suffix = ""
      --   -- get current ISO datetime with -5 hour offset from UTC for EST
      --   local current_datetime = os.date("!%Y-%m-%d-%H%M%S", os.time() - 5*3600)
      --   if title ~= nil then
      --     suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
      --   else
      --     for _ = 1, 4 do
      --       suffix = suffix .. string.char(math.random(65, 90))
      --     end
      --   end
      --   return current_datetime .. "_" .. suffix
      -- end,

      -- key mappings, below are the defaults
      mappings = {
        -- overrides the 'gf' mapping to work on markdown/wiki links within your vault
        ["gf"] = {
          action = function()
            return require("obsidian").util.gf_passthrough()
          end,
          opts = { noremap = false, expr = true, buffer = true },
        },
        -- toggle check-boxes
        -- ["<leader>ch"] = {
        --   action = function()
        --     return require("obsidian").util.toggle_checkbox()
        --   end,
        --   opts = { buffer = true },
        -- },
      },
      completion = {
        nvim_cmp = true,
        min_chars = 2,
      },
      ui = {
        -- Disable some things below here because I set these manually for all Markdown files using treesitter
        checkboxes = {},
        bullets = {},
      },
    })

    --
    vim.opt.conceallevel = 2

    -- checkbox
    vim.keymap.set("n", "<leader>cy", [[:s/\[\s\]/[x]/<cr>]], { silent = true, desc = "checkbox toggle" })
    vim.keymap.set("n", "<leader>cu", [[:s/\[x\]/[ ]/<cr>]], { silent = true, desc = "checkbox untoggle" })

    -- navigate to vault
    vim.keymap.set(
      "n",
      "<leader>oo",
      ":cd $HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/MartVault<cr>",
      { desc = "navigate to obsidian vault" }
    )

    -- convert note to template and remove leading white space
    vim.keymap.set(
      "n",
      "<leader>on",
      ":ObsidianTemplate note<cr> :lua vim.cmd([[1,/^\\S/s/^\\n\\{1,}//]])<cr>",
      { desc = "apply template to note" }
    )
    -- strip date from note title and replace dashes with spaces
    -- must have cursor on title
    vim.keymap.set(
      "n",
      "<leader>of",
      ":s/\\(# \\)[^_]*_/\\1/ | s/-/ /g<cr>",
      { desc = "strip date and replace dashes with spaces" }
    )

    -- search for files in full vault
    -- vim.keymap.set("n", "<leader>fn", function()
    --   require("fzf-lua").live_grep_glob({
    --     cwd = "$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/MartVault",
    --   })
    -- end, { desc = "Fzf note in vault" })
    --
    -- vim.keymap.set("n", "<leader>fv", function()
    --   require("fzf-lua").files({
    --     cwd = "$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/MartVault",
    --   })
    -- end, { desc = "Fzf note in vault" })

    vim.keymap.set("n", "<leader>fn", ":ObsidianSearch<cr>", { desc = "search note in vault" })

    -- move file in current buffer to notes folder
    vim.keymap.set(
      "n",
      "<leader>ok",
      ":!mv '%:p' $HOME/library/Mobile\\ Documents/iCloud~md~obsidian/Documents/MartVault/zettelkasten<cr>:bd<cr>",
      { desc = "accept note and move to zettelkasten folder" }
    )

    -- move todo note in current buffer to todo folder
    vim.keymap.set(
      "n",
      "<leader>omt",
      ":!mv '%:p' $HOME/library/Mobile\\ Documents/iCloud~md~obsidian/Documents/MartVault/todo<cr>:bd<cr>",
      { desc = "move note to todo folder" }
    )

    -- move file in current buffer to remove folder
    vim.keymap.set(
      "n",
      "<leader>odd",
      ":!mv '%:p' $HOME/library/Mobile\\ Documents/iCloud~md~obsidian/Documents/MartVault/wastebasket<cr>:bd<cr>",
      { desc = "move file to waste folder to delete later" }
    )
    -- delete file in current buffer
    -- vim.keymap.set("n", "<leader>odd", ":!rm '%:p'<cr>:bd<cr>", { desc = "DELETE file forever" })
  end,
}
