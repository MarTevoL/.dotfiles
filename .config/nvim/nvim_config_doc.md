# Neovim Configuration Documentation

This document provides a brief overview of your Neovim configuration, focusing on how keymaps and plugins are set up and how to use them effectively.

## 1. Core Configuration (`lua/martevol/core/`)

Your core Neovim settings are located in `lua/martevol/core/`.

*   **`options.lua`**: This file defines global Neovim options such as:
    *   `relativenumber = true` and `number = true`: Enables relative and absolute line numbers.
    *   `tabstop = 2`, `shiftwidth = 2`, `expandtab = true`: Configures tab and indentation settings to use 2 spaces.
    *   `termguicolors = true`: Enables true color support for your colorscheme.
    *   `splitright = true` and `splitbelow = true`: Controls how new windows are split.
    *   `swapfile = false`: Disables swap files.

*   **`keymaps.lua`**: This file defines your custom keybindings. Your leader key is set to `<Space>`.

    Here are some of the keybindings defined:

    | Keybinding      | Description                               |
    | :-------------- | :---------------------------------------- |
    | `jk`            | Exit insert mode                          |
    | `<leader>nh`    | Clear search highlights                   |
    | `<leader>nd`    | Dismiss Noice messages                    |
    | `vJ`            | Move selected lines down (visual mode)    |
    | `vK`            | Move selected lines up (visual mode)      |
    | `<leader>+`     | Increment number                          |
    | `<leader>-`     | Decrement number                          |
    | `<leader>sv`    | Split window vertically                   |
    | `<leader>sh`    | Split window horizontally                 |
    | `<leader>se`    | Make splits equal size                    |
    | `<leader>sx`    | Close current split                       |

## 2. Plugin Management (`lua/martevol/lazy.lua` and `lua/martevol/plugins/`)

Your Neovim setup uses `lazy.nvim` for plugin management. The main configuration for `lazy.nvim` is in `lua/martevol/lazy.lua`, which then imports individual plugin configurations from the `lua/martevol/plugins/` directory.

Each plugin typically has its own `.lua` file within `lua/martevol/plugins/` (or subdirectories like `lsp/` and `neoscroll/`). These files contain the plugin's setup function and any specific configurations or keybindings related to that plugin.

### How Plugins are Structured

A typical plugin configuration file looks like this:

```lua
return {
  "plugin_author/plugin_name", -- The plugin's GitHub repository
  event = "VimEnter", -- When the plugin should be loaded (e.g., "VeryLazy", "InsertEnter", "BufReadPre")
  dependencies = { -- Other plugins this plugin depends on
    "another_author/another_plugin",
  },
  config = function()
    -- Plugin-specific setup and configuration options
    require("plugin_name").setup({
      -- ... plugin options ...
    })
  end,
  keys = { -- Keybindings specific to this plugin
    { "<leader>pk", function() require("plugin_name").do_something() end, desc = "Do something" },
  },
}
```

### Key Plugins and Their Usage

Here's a detailed overview of each plugin, its function, how to use it, and specific keymap examples:

*   **`alpha-nvim` (Dashboard/Start Screen)**
    *   **Function:** Provides a highly customizable start screen for Neovim, displaying a welcome message and a menu of common actions.
    *   **How to Use:** It automatically appears when Neovim starts or when all buffers are closed. You interact with it by pressing the key corresponding to the desired action.
    *   **Example Keymaps/Buttons:**
        *   `e`: Create a new empty file.
        *   `<Space>ee`: Toggle the NvimTree file explorer.
        *   `<Space>ff`: Open Telescope to find files in your current working directory.
        *   `<Space>fs`: Open Telescope to live grep (search for a word) in your current working directory.
        *   `<Space>wr`: Restore a saved session for the current directory (using `auto-session`).
        *   `q`: Quit Neovim.

*   **`auto-session` (Session Management)**
    *   **Function:** Automatically saves and restores your Neovim sessions based on your current working directory. This helps maintain your work environment across Neovim restarts.
    *   **How to Use:** While automatic restoration is disabled in your configuration, you can manually save and restore sessions.
    *   **Keymaps:**
        *   `<leader>wr`: Restore the last workspace session for the current directory.
        *   `<leader>ws`: Save the workspace session for the current working directory.

*   **`nvim-autopairs` (Auto-pairing)**
    *   **Function:** Automatically inserts and deletes matching parentheses, brackets, quotes, and other pairs as you type, improving typing efficiency and reducing syntax errors. It integrates with `nvim-cmp` and Treesitter.
    *   **How to Use:** Simply type an opening character (e.g., `(`, `{`, `[`, `"`, `'`) and the plugin will automatically insert the corresponding closing character. Deleting an opening character will also remove its pair. No specific keymaps are needed for its core functionality.
    *   **Keymaps:** (No direct keymaps for core functionality; it works automatically.)

*   **`bufferline.nvim` (Bufferline/Tabs)**
    *   **Function:** Provides a customizable bufferline at the top of your Neovim window, displaying open files as tabs.
    *   **How to Use:** This plugin is currently **disabled** in your configuration (`enabled = false`). To use it, you would need to enable it in `lua/martevol/plugins/bufferline.lua`. Once enabled, it will automatically show your open buffers. You can navigate between them using standard Neovim buffer commands (e.g., `:bnext`, `:bprev`, `:buffer <number>`).
    *   **Keymaps:** (No specific keymaps defined in your configuration for this disabled plugin.)

*   **`dracula.nvim` (Colorscheme)**
    *   **Function:** Applies the Dracula colorscheme to your Neovim interface, providing a dark theme with specific color palettes for syntax highlighting and UI elements.
    *   **How to Use:** The colorscheme is automatically loaded and applied when Neovim starts. You can modify its appearance by adjusting the `colors` table and `overrides` within the `config` function in `lua/martevol/plugins/colorscheme.lua`.
    *   **Keymaps:** (No specific keymaps associated with this plugin as it primarily controls the visual theme.)

*   **`Comment.nvim` (Code Commenting)**
    *   **Function:** Provides a simple and extensible way to comment and uncomment lines or blocks of code. It integrates with Treesitter to intelligently determine the correct comment string for different file types and contexts (e.g., `//` for JavaScript, `--` for Lua, `<!-- -->` for HTML).
    *   **How to Use:** This plugin typically uses default keybindings. You can use it in normal, visual, or operator-pending modes.
    *   **Example Keymaps (Default):**
        *   `gcc`: Comment/uncomment the current line.
        *   `gc<motion>`: Comment/uncomment the text covered by the motion (e.g., `gcap` to comment a paragraph, `gcw` to comment a word).
        *   `gbc`: Comment/uncomment the current line using block comments.
        *   `gb<motion>`: Comment/uncomment the text covered by the motion using block comments.

*   **`dressing.nvim` (UI Enhancements)**
    *   **Function:** Enhances the appearance and usability of Neovim's built-in UI elements, such as selection menus (`vim.ui.select`) and input prompts (`vim.ui.input`), by replacing them with more modern and interactive floating windows or popups.
    *   **How to Use:** This plugin works automatically in the background. When Neovim or another plugin requires user input via a selection list or a text prompt, `dressing.nvim` will provide the enhanced UI.
        *   **Code Action Window Size:** Your configuration specifically targets `vim.ui.select` when it's used for `codeaction` prompts. It sets the backend to `fzf` and configures the `fzf` window to be `0.5` (50%) of the editor's width and height. This ensures that the code action floating window is a consistent and manageable size.
    *   **Keymaps:** (No specific keymaps are associated with this plugin; it enhances existing UI interactions.)

*   **`flash.nvim` (Fast Navigation and Selection)**
    *   **Function:** Provides a highly efficient and visual way to navigate and select text within your buffer. It allows you to jump to any character or word on the screen with minimal keystrokes.
    *   **How to Use:**
        *   **Basic Jump (`<leader>jj`):** Press `<leader>jj`, then type the character(s) you want to jump to. `flash.nvim` will highlight all occurrences and assign a unique key to each. Press the assigned key to jump to that location.
        *   **Treesitter Jump (`<leader>jt`):** Similar to basic jump, but uses Treesitter to identify and jump to specific code structures (e.g., function definitions, variable declarations).
        *   **Toggle Search (`<C-s>` in command mode):** Toggles a persistent Flash search mode.
    *   **Keymaps:**
        *   `<leader>jj`: Initiate a Flash jump (Normal, Visual, Operator-pending modes).
        *   `<leader>jt`: Initiate a Flash jump using Treesitter (Normal, Visual, Operator-pending modes).
        *   `<C-s>` (in command mode): Toggle Flash Search.

*   **`gitsigns.nvim` (Git Integration)**
    *   **Function:** Displays Git status information directly in the Neovim sign column. It shows indicators for added (`+`), changed (`~`), and deleted (`_`) lines, providing an immediate visual overview of your Git modifications.
    *   **How to Use:** This plugin works automatically. As you make changes to a Git-tracked file, the signs will appear in the left-most column.
    *   **Keymaps:**
        *   `<leader>ph`: Preview the Git hunk (a block of changes) under the cursor. This opens a popup showing the exact changes for that section of code.

*   **`harpoon` (Quick File Navigation)**
    *   **Function:** `harpoon` allows you to "harpoon" (mark) important files and quickly jump between them. This is incredibly useful for navigating frequently accessed files in a project without relying on fuzzy finders or buffer lists.
    *   **How to Use:**
        *   **Add a file:** Use `<leader>H` to add the current file to your harpoon list.
        *   **Open Quick Menu:** Use `<leader>h` to open a quick menu displaying your harpooned files. From this menu, you can select a file to jump to.
        *   **Direct Jump:** Use `<leader>1>` through `<leader>5>` to directly jump to the first five harpooned files.
    *   **Keymaps:**
        *   `<leader>H`: Add the current file to the harpoon list.
        *   `<leader>h`: Toggle the harpoon quick menu.
        *   `<leader>1`: Jump to the first harpooned file.
        *   `<leader>2`: Jump to the second harpooned file.
        *   ...and so on, up to `<leader>5`.

*   **`indent-blankline.nvim` (Indentation Guides)**
    *   **Function:** Displays indentation guides (vertical lines) in your code, making it easier to visualize the indentation level and structure of your code, especially in languages with significant whitespace or deeply nested blocks.
    *   **How to Use:** This plugin works automatically. Once enabled, you will see vertical lines indicating indentation levels. Your configuration uses the character `┊` for these lines.
    *   **Keymaps:** (No specific keymaps associated with this plugin; it provides a visual aid.)

*   **`lazydev.nvim` (Lua Development Utilities)**
    *   **Function:** This plugin provides development utilities specifically for Lua, including type definitions for Neovim's Lua API (`vim.uv`) and integration with `nvim-cmp` for improved completion in Lua files.
    *   **How to Use:** This plugin is primarily for developers working with Neovim's Lua configuration. It loads automatically when you open Lua files (`ft = "lua"`). It enhances your Lua development experience by providing better autocompletion and type checking.
    *   **Keymaps:** (No specific keymaps are associated with this plugin; it enhances the Lua development environment.)

*   **`lazydev.nvim` (Lua Development Utilities)**
    *   **Function:** This plugin provides development utilities specifically for Lua, including type definitions for Neovim's Lua API (`vim.uv`) and integration with `nvim-cmp` for improved completion in Lua files.
    *   **How to Use:** This plugin is primarily for developers working with Neovim's Lua configuration. It loads automatically when you open Lua files (`ft = "lua"`). It enhances your Lua development experience by providing better autocompletion and type checking.
    *   **Keymaps:** (No specific keymaps are associated with this plugin; it enhances the Lua development environment.)

*   **`lualine.nvim` (Status Line)**
    *   **Function:** Provides a fast and highly customizable status line at the bottom of your Neovim window. It displays essential information about your current buffer and Git status.
    *   **How to Use:** This plugin works automatically and displays information such as:
        *   **Git Status:** Current branch and file changes (additions, modifications).
        *   **File Information:** Filename, whether it's modified, read-only, unnamed, or a new file.
        *   **Encoding and Filetype:** The current file's encoding and detected filetype.
        *   **Noice Status:** Integrates with `noice.nvim` to show its status when active.
    *   **Keymaps:** (No specific keymaps are associated with this plugin; it provides a visual display.)

*   **`mini.icons` (Icon Provider)**
    *   **Function:** This plugin provides a set of beautiful file and folder icons for Neovim. It's configured to "mock" `nvim-web-devicons`, meaning that any other plugin that requests icons from `nvim-web-devicons` will instead receive icons from `mini.icons`. This ensures consistent and visually appealing icons throughout your Neovim setup.
    *   **How to Use:** This plugin works automatically in the background. You will see file and folder icons displayed in various Neovim components (e.g., file explorers, status lines) where icons are supported.
    *   **Keymaps:** (No specific keymaps are associated with this plugin; it provides visual icons.)

*   **`vim-visual-multi` (Multi-Cursor Editing)**
    *   **Function:** Provides powerful multi-cursor editing capabilities, similar to those found in Sublime Text or VS Code. It allows you to add multiple cursors to different locations in your file and edit them simultaneously.
    *   **How to Use:**
        *   **Add Cursor Under:** Use `<C-x>` to add a new cursor under the current one, searching for the next occurrence of the word under the cursor.
        *   **Add Cursor at Position:** Use `<C-m>` to add a new cursor at the current cursor position.
        *   **Add Cursor Down:** Use `<leader>vj` to add a cursor on the line below the current cursor.
        *   **Toggle Mappings:** Use `<leader>vm` to toggle the default mappings of `vim-visual-multi`.
    *   **Keymaps:**
        *   `<C-x>`: Add a new cursor under the current one (find next occurrence).
        *   `<C-m>`: Add a new cursor at the current position.
        *   `<leader>vj`: Add a cursor on the line below.
        *   `<leader>vm`: Toggle default mappings.

*   **`my_plugin.lua` (Placeholder/Inactive Plugin)**
    *   **Function:** This file is currently empty and does not configure any active plugin. It appears to be a placeholder or a configuration for a plugin that was previously used but is now commented out or removed.
    *   **How to Use:** As it's inactive, there's no direct usage. If you intend to add a custom plugin or re-enable a previously used one, this file might serve as a starting point.
    *   **Keymaps:** (None, as the plugin is inactive.)

*   **`neogit` (Git Client)**
    *   **Function:** `neogit` is a full-featured Git client for Neovim, inspired by Magit from Emacs. It provides an interactive interface for managing your Git repositories, including staging/unstaging changes, committing, branching, rebasing, and more.
    *   **How to Use:** To open the `neogit` status buffer, you typically use the command `:Neogit`. From there, you can navigate and interact with your Git repository using `neogit`'s intuitive keybindings (which are displayed within the `neogit` buffer).
    *   **Keymaps:** Your configuration sets `config = true`, which means `neogit` will use its default keybindings. You would typically open `neogit` with `:Neogit` and then use its internal keybindings.

*   **`neotest` (Testing Framework)**
    *   **Function:** `neotest` is a powerful and extensible testing framework for Neovim. It allows you to run tests, view test results, and navigate between test failures directly within your editor. Your configuration includes `neotest-dart`, indicating support for Dart/Flutter tests.
    *   **How to Use:** You can run tests at various scopes (file, nearest test, all tests in directory) and view their output and summary.
    *   **Keymaps:**
        *   `<leader>t`: This is a prefix for all test-related keymaps.
        *   `<leader>tt`: Run tests in the current file.
        *   `<leader>tT`: Run all test files in the current working directory.
        *   `<leader>tr`: Run the nearest test (test under cursor or in the current function/block).
        *   `<leader>tl`: Run the last executed test.
        *   `<leader>ts`: Toggle the test summary window, which shows an overview of test results.
        *   `<leader>to`: Open the test output window, showing detailed logs from the test run.
        *   `<leader>tO`: Toggle the test output panel.
        *   `<leader>tS`: Stop any currently running tests.
        *   `<leader>tw`: Toggle watch mode for tests in the current file. In watch mode, tests automatically re-run when the file changes.

*   **`noice.nvim` (Notifications and UI)**
    *   **Function:** `noice.nvim` is a Neovim plugin that aims to make the Neovim UI more modern and user-friendly by replacing the default command-line, messages, and popups with a more aesthetically pleasing and functional interface. It handles notifications, command previews, and LSP documentation.
    *   **How to Use:** `noice.nvim` works largely automatically, intercepting and re-rendering Neovim's messages and UI elements. You'll notice its effects when commands are executed, notifications appear, or when interacting with LSP features.
    *   **Keymaps:**
        *   `<leader>nd`: Dismiss Noice messages. This keymap is defined in your `keymaps.lua` and allows you to clear any active Noice notifications.

*   **`nvim-cmp` (Autocompletion Framework)**
    *   **Function:** `nvim-cmp` is a powerful and highly configurable completion framework for Neovim. It aggregates completion suggestions from various sources (LSP, buffer, snippets, file paths) and presents them in a unified menu. It integrates with `luasnip` for snippet expansion and `lspkind` for visual icons.
    *   **How to Use:** As you type in insert mode, `nvim-cmp` will automatically display a completion menu. You can navigate this menu and select suggestions.
    *   **Keymaps:**
        *   `<C-k>` or `<Up>`: Select the previous suggestion in the completion menu.
        *   `<C-j>` or `<Down>`: Select the next suggestion in the completion menu.
        *   `<C-Space>`: Manually trigger completion suggestions.
        *   `<CR>` (Enter): Confirm the selected suggestion.
        *   `<C-e>`: Abort (close) the completion window.
        *   `<C-b>`: Scroll documentation up in the preview window.
        *   `<C-f>`: Scroll documentation down in the preview window.
        *   **Snippet-related (with `luasnip`):**
            *   `<C-L>`: Expand the current snippet.
            *   `<C-K>`: Jump to the next placeholder within an expanded snippet.
            *   `<C-J>`: Jump to the previous placeholder within an expanded snippet.
            *   `<C-E>`: Cycle through choices in a snippet (if a choice is active).

*   **`nvim-colorizer.lua` (Colorizer)**
    *   **Function:** This plugin highlights CSS colors (hex codes, RGB/HSL functions, named colors) directly in your code, making it easier to visualize and work with colors.
    *   **How to Use:** This plugin is currently **disabled** in your configuration (`enabled = false`). To use it, you would need to change `enabled = false` to `enabled = true` in its configuration file (`lua/martevol/plugins/nvim-colorizer.lua`). Once enabled, it will automatically highlight color codes in supported files.
    *   **Keymaps:** (No specific keymaps are associated with this plugin; it provides visual highlighting.)

*   **`nvim-dap` (Debugger)**
    *   **Function:** `nvim-dap` is a Debug Adapter Protocol (DAP) client for Neovim. It allows you to debug your code directly within Neovim by connecting to various debuggers (via DAP adapters). Your configuration includes specific setups for Dart/Flutter debugging.
    *   **How to Use:**
        *   **Breakpoints:** Set and toggle breakpoints to pause execution at specific lines.
        *   **Control Execution:** Continue, step over, step into, and step out of code.
        *   **Inspect Variables:** View the values of variables and expressions.
        *   **DAP UI:** Use `nvim-dap-ui` (a dependency) to visualize the debugger state (variables, call stack, breakpoints) in a user-friendly interface.
        *   **Flutter Debugging:** Your configuration defines several launch configurations for Flutter, allowing you to debug different flavors (development, mock, production, staging) and select a target device.
    *   **Keymaps:**
        *   `<leader>dbp`: Toggle a breakpoint on the current line.
        *   `<leader>dtr`: Toggle the DAP REPL (Read-Eval-Print Loop), allowing you to execute code in the debugger's context.
        *   `<leader>dc`: Continue program execution until the next breakpoint or end of the program.
        *   `<leader>dut`: Toggle the DAP UI, which displays debugger information panels.
        *   `<leader>due`: Evaluate the expression under the cursor in the debugger's context.
        *   `<leader>duf`: Float a DAP UI element (e.g., a variable's value) in a separate window.

*   **`vim-tmux-navigator` (Tmux Integration)**
    *   **Function:** This plugin allows seamless navigation between Neovim panes and Tmux panes using the same keybindings. This is incredibly useful if you use Tmux as your terminal multiplexer, as it eliminates the need to switch between different keybinding sets for navigation.
    *   **How to Use:** When you are in Neovim, you can use the specified keybindings to move your cursor between Neovim windows. If there are no more Neovim windows in that direction, it will automatically switch to the adjacent Tmux pane.
    *   **Keymaps:**
        *   `<C-h>`: Navigate left (Neovim window or Tmux pane).
        *   `<C-j>`: Navigate down (Neovim window or Tmux pane).
        *   `<C-k>`: Navigate up (Neovim window or Tmux pane).
        *   `<C-l>`: Navigate right (Neovim window or Tmux pane).

*   **`nvim-tree.lua` (File Explorer)**
    *   **Function:** `nvim-tree.lua` is a file explorer plugin for Neovim that provides a tree-like view of your project's file system. It allows you to browse, open, create, delete, and rename files and directories directly within Neovim. It also displays Git status and diagnostic information for files.
    *   **How to Use:** You can toggle the file explorer, find the current file in the tree, collapse the tree, and refresh it using the defined keymaps.
    *   **Keymaps:**
        *   `<leader>ee`: Toggle the file explorer sidebar.
        *   `<leader>ef`: Toggle the file explorer and reveal the current file in the tree.
        *   `<leader>ec`: Collapse all open directories in the file explorer.
        *   `<leader>er`: Refresh the file explorer to show the latest file system changes.

*   **`nvim-treesitter-textobjects` (Treesitter Text Objects)**
    *   **Function:** This plugin extends Neovim's built-in text objects (like `iw` for "inner word", `ap` for "a paragraph") to be more semantically aware, leveraging Treesitter's understanding of code structure. This allows for more intelligent and precise selections and movements based on code syntax (e.g., selecting an entire function, a class, or an argument list).
    *   **How to Use:** You combine these text objects with Neovim's operators (e.g., `d` for delete, `y` for yank, `v` for visual select) to perform actions on code blocks.
    *   **Keymaps:**
        *   **Selection (`select`):**
            *   `a=`: Select an entire assignment statement (outer part).
            *   `i=`: Select the inner part of an assignment statement.
            *   `r=`: Select the right-hand side of an assignment.
            *   `a:`: Select an entire object property (outer part, for JS/TS).
            *   `i:`: Select the inner part of an object property (for JS/TS).
            *   `r:`: Select the right-hand side of an object property (for JS/TS).
            *   `aa`: Select an entire parameter/argument (outer part).
            *   `ia`: Select the inner part of a parameter/argument.
            *   `ai`: Select an entire conditional statement (outer part).
            *   `ii`: Select the inner part of a conditional statement.
            *   `al`: Select an entire loop (outer part).
            *   `il`: Select the inner part of a loop.
            *   `af`: Select an entire function call (outer part).
            *   `if`: Select the inner part of a function call.
            *   `am`: Select an entire method/function definition (outer part).
            *   `im`: Select the inner part of a method/function definition.
            *   `ac`: Select an entire class (outer part).
            *   `ic`: Select the inner part of a class.
        *   **Movement (`move`):**
            *   `]`f`: Jump to the start of the next function call.
            *   `]`m`: Jump to the start of the next method/function definition.
            *   `]]`: Jump to the next parameter.
            *   `[f`: Jump to the start of the previous function call.
            *   `[[`: Jump to the previous parameter.
        *   **Repeat Move:**
            *   `,`: Repeat the last text object move in the same direction.
            *   `;`: Repeat the last text object move in the opposite direction.

*   **`fzf-lua` (Fuzzy Finder)**
    *   **Function:** `fzf-lua` is a powerful fuzzy finder that integrates `fzf` (a command-line fuzzy finder) with Neovim. It provides a fast and interactive way to search for files, grep content, find LSP references, and more.
    *   **How to Use:** You invoke `fzf-lua` commands via its keymaps. When a `fzf-lua` picker opens, you can type to fuzzy-filter the results.
    *   **Keymaps:**
        *   `<leader>f<`: Resume the last `FzfLua` command. This is useful if you close a picker and want to reopen it with the same search context.
        *   `<leader>fb`: Grep the content of the current buffer. This allows you to quickly search for text within the file you are currently editing.
        *   `<leader>fc`: Display Neovim's highlight groups. Useful for theme customization or understanding syntax highlighting.
        *   `<leader>fr`: Find all LSP references for the symbol under the cursor.
        *   `<leader>fi`: Find all LSP implementations for the symbol under the cursor.
        *   `<leader>fd`: Show diagnostics for the current document.
        *   `<leader>fD`: Show diagnostics for the entire workspace.
        *   `<leader>ff`: Find files in your project. This is one of the most frequently used `fzf-lua` commands.
        *   `<leader>fg`: Perform a live grep across your project files. This allows you to search for patterns within file contents.
        *   `<leader>fv` (visual mode): Grep for the currently selected word. This is a convenient way to search for the definition or usage of a variable/function you've highlighted.
        *   `<leader>fl`: Repeat the last grep command.
        *   `<leader>fh`: Search Neovim's help tags.

*   **`nvim-cmp` (Autocompletion)**
    *   `<C-k>` or `<Up>`: Select previous suggestion.
    *   `<C-j>` or `<Down>`: Select next suggestion.
    *   `<C-Space>`: Show completion suggestions.
    *   `<CR>`: Confirm selected suggestion.
    *   `<C-L>`: Expand Luasnip snippet.
    *   `<C-K>`: Jump to next placeholder in snippet.
    *   `<C-J>`: Jump to previous placeholder in snippet.

*   **`nvim-dap` (Debugger)**
    *   `<leader>dbp`: Toggle breakpoint.
    *   `<leader>dtr`: Toggle DAP REPL.
    *   `<leader>dc`: Continue debugging.
    *   `<leader>dut`: Toggle DAP UI.
    *   `<leader>due`: Evaluate expression in DAP UI.
    *   `<leader>duf`: Float DAP UI element.
    *   **Flutter Debugging**: Your configuration includes specific setups for Flutter debugging, allowing you to launch different flavors (development, mock, production, staging) and select devices.

*   **`neotest` (Testing Framework)**
    *   `<leader>tt`: Run tests in the current file.
    *   `<leader>tT`: Run all tests in the current directory.
    *   `<leader>tr`: Run nearest test.
    *   `<leader>tl`: Run last test.
    *   `<leader>ts`: Toggle test summary.
    *   `<leader>to`: Show test output.
    *   `<leader>tO`: Toggle test output panel.
    *   `<leader>tS`: Stop running tests.
    *   `<leader>tw`: Toggle watch mode for tests.

*   **`obsidian.nvim` (Note Taking)**
    *   `<leader>fn`: Search notes in your vault.
    *   `<leader>ok`: Move current buffer to `zettelkasten` folder.
    *   `<leader>omt`: Move current buffer to `todo` folder.
    *   `<leader>odd`: Move current buffer to `wastebasket` folder.

*   **`obsidian.nvim` (Note Taking)**
    *   **Function:** This plugin integrates Neovim with Obsidian, a popular knowledge base and note-taking application. It allows you to manage your Obsidian vault directly from Neovim, including creating new notes, navigating between notes, and managing checkboxes.
    *   **How to Use:**
        *   **Workspaces:** Your configuration defines a workspace named "MartVault" located at `/Users/truongle/Library/Mobile Documents/iCloud~md~obsidian/Documents/MartVault`.
        *   **New Notes:** New notes are created in the `inbox` subdirectory within your vault.
        *   **Navigation:** Use `gf` to follow Markdown/wiki links within your vault.
        *   **Checkboxes:** Toggle checkboxes in Markdown files.
        *   **Templates:** Apply templates to new notes.
        *   **Vault Navigation:** Navigate to your Obsidian vault directory.
        *   **Note Management:** Move notes to specific folders within your vault.
    *   **Keymaps:**
        *   `gf`: Go to file/link under cursor (within Obsidian vault).
        *   `<leader>cy`: Toggle checkbox to "checked" (`[ ]` to `[x]`).
        *   `<leader>cu`: Toggle checkbox to "unchecked" (`[x]` to `[ ]`).
        *   `<leader>oo`: Navigate to your Obsidian vault directory.
        *   `<leader>on`: Apply a template named "note" to the current file and remove leading whitespace.
        *   `<leader>of`: Strip date from note title and replace dashes with spaces.
        *   `<leader>fn`: Search for notes within your Obsidian vault.
        *   `<leader>ok`: Move the current buffer (note) to the `zettelkasten` folder and close the buffer.
        *   `<leader>omt`: Move the current buffer (note) to the `todo` folder and close the buffer.
        *   `<leader>odd`: Move the current buffer (note) to the `wastebasket` folder and close the buffer.

*   **`oil.nvim` (File Explorer)**
    *   **Function:** `oil.nvim` is a file explorer that allows you to navigate your file system within a Neovim buffer. Unlike traditional tree-based file explorers, `oil.nvim` presents directories as regular buffers, allowing you to use standard Neovim motions and commands for navigation and manipulation.
    *   **How to Use:**
        *   **Open Parent Directory:** Use `-` to open the parent directory of the current file in the current window.
        *   **Open Parent Directory in Floating Window:** Use `<Space>-` to open the parent directory in a floating window.
    *   **Keymaps:**
        *   `-`: Open the parent directory in the current window.
        *   `<Space>-`: Open the parent directory in a floating window.

*   **`render-markdown.nvim` (Markdown Rendering)**
    *   **Function:** This plugin provides a way to render Markdown files directly within Neovim, making them more readable by applying syntax highlighting and proper formatting.
    *   **How to Use:** This plugin is enabled in your configuration and should automatically render Markdown files when you open them. You don't need to invoke any specific commands or keymaps for its basic functionality.
    *   **Keymaps:** (No specific keymaps are associated with this plugin; it provides visual rendering.)

*   **`nvim-surround` (Surrounding Text Objects)**
    *   **Function:** This plugin provides powerful commands for surrounding text objects with various delimiters (parentheses, brackets, quotes, HTML tags, etc.) and for changing or deleting existing surroundings. It's a highly efficient way to manipulate text structures.
    *   **How to Use:** `nvim-surround` uses a set of intuitive commands that combine an action (yank, change, delete), a target (the surrounding character), and a motion or text object.
    *   **Example Commands (not direct keymaps, but how you'd use it):**
        *   `ysiw)`: **Y**ank **s**urround **i**nner **w**ord with `)`. If your cursor is on `word`, it becomes `(word)`.
        *   `ys$" `: **Y**ank **s**urround **d**ouble **q**uote with a space. If your cursor is on `text`, it becomes `" text "`.
        *   `ds]`: **D**elete **s**urround `]`. If you have `[text]`, it becomes `text`.
        *   `dst`: **D**elete **s**urround **t**ag. If you have `<b>text</b>`, it becomes `text`.
        *   `cs'" `: **C**hange **s**urround from single quote to double quote. If you have `'text'`, it becomes `"text"`.
        *   `csth1<CR>`: **C**hange **s**urround from tag to `<h1>`. If you have `<b>text</b>`, it becomes `<h1>text</h1>`.
        *   `dsf`: **D**elete **s**urround **f**unction call. If you have `func(arg)`, it becomes `arg`.

*   **`telescope.nvim` (Fuzzy Finder)**
    *   **Function:** `telescope.nvim` is a highly extensible fuzzy finder for Neovim, providing a powerful and interactive interface for searching, filtering, and selecting various items (files, buffers, Git commits, LSP symbols, etc.). It's designed for speed and flexibility.
    *   **How to Use:** You invoke Telescope pickers using commands or keymaps. Once a picker is open, you can type to fuzzy-filter the results.
    *   **Keymaps:**
        *   `<C-k>` (in picker): Move selection to the previous result.
        *   `<C-j>` (in picker): Move selection to the next result.
        *   `<C-q>` (in picker): Send selected entries to the quickfix list and open the `trouble.nvim` quickfix list.
        *   `<leader>ft`: Find TODO comments using `todo-comments.nvim` integration.
        *   `<leader>b`: Show all open buffers.
        *   **Note:** Your configuration has commented out some common Telescope keymaps (`<leader>ff`, `<leader>fr`, `<leader>fs`, `<leader>fc`), indicating that you might be primarily using `fzf-lua` for those specific search functions.

*   **`nvim-coverage` (Test Coverage Visualization)**
    *   **Function:** This plugin visualizes test coverage directly in your Neovim buffer. It highlights lines of code based on whether they are covered by tests, helping you identify untested areas of your codebase.
    *   **How to Use:** This plugin works by integrating with your test runner (likely `neotest` in your setup). After running tests, `nvim-coverage` will display visual indicators in the sign column:
        *   Green (`▎`): Covered lines.
        *   Red (`▎`): Uncovered lines.
    *   **Keymaps:** This plugin primarily provides visual feedback. You would typically run your tests using `neotest`'s keymaps, and `nvim-coverage` would then display the results.

*   **`todo-comments.nvim` (TODO Comments)**
    *   **Function:** This plugin highlights, lists, and helps you navigate through TODO, FIXME, HACK, and other similar comments in your code. It makes it easy to keep track of pending tasks and notes within your codebase.
    *   **How to Use:** The plugin automatically highlights recognized todo comments. You can use the provided keymaps to jump between them.
    *   **Keymaps:**
        *   `]t`: Jump to the next TODO comment.
        *   `[t`: Jump to the previous TODO comment.

*   **`nvim-treesitter` (Syntax Highlighting and Parsing)**
    *   **Function:** `nvim-treesitter` is a powerful plugin that leverages Treesitter parsers to provide advanced syntax highlighting, intelligent code navigation, and structural editing capabilities. It parses your code into a syntax tree, allowing Neovim to understand the code's structure rather than just treating it as plain text.
    *   **How to Use:**
        *   **Syntax Highlighting:** Treesitter provides more accurate and granular syntax highlighting than traditional regex-based methods. This works automatically once the plugin is set up for a language.
        *   **Indentation:** It can also handle intelligent indentation based on the code structure.
        *   **Autotagging:** Integrates with `nvim-ts-autotag` to automatically close HTML/JSX tags.
        *   **Incremental Selection:** Allows you to expand your selection incrementally based on the code's syntax tree.
    *   **Keymaps:**
        *   `<C-s>`: Initiate or expand an incremental selection (in visual mode).
        *   `<bs>` (backspace): Decrement an incremental selection.

*   **`trouble.nvim` (Diagnostics and Location List)**
    *   **Function:** `trouble.nvim` is a Neovim plugin that provides a beautiful and organized way to view and navigate diagnostics (errors, warnings, info messages from LSP), location lists, and quickfix lists. It aggregates these lists into a single, easy-to-use interface.
    *   **How to Use:** You can toggle different types of "trouble" lists using the provided keymaps.
    *   **Keymaps:**
        *   `<leader>xx`: Toggle the main trouble list (which can show diagnostics, quickfix, or location list depending on context).
        *   `<leader>xw`: Toggle workspace diagnostics (diagnostics for the entire project).
        *   `<leader>xd`: Toggle document diagnostics (diagnostics for the current file).
        *   `<leader>xq`: Toggle the quickfix list.
        *   `<leader>xl`: Toggle the location list.
        *   `<leader>xt`: Open TODO comments in the trouble list (integrates with `todo-comments.nvim`).

*   **`nvim-ufo` (Folding)**
    *   **Function:** `nvim-ufo` (Unfold Fold Objects) is a Neovim plugin that provides advanced code folding capabilities. It aims to offer a more flexible and performant folding experience, especially for large files and complex code structures, by leveraging LSP and Treesitter.
    *   **How to Use:** This plugin works automatically to create and manage code folds. You can use standard Neovim folding commands to open, close, and toggle folds. Your configuration sets `foldlevelstart = 99`, which means all folds will be open by default when you open a file. It also excludes certain file types from UFO's folding.
    *   **Example Keymaps (Standard Neovim folding commands):**
        *   `za`: Toggle fold under cursor.
        *   `zc`: Close fold under cursor.
        *   `zo`: Open fold under cursor.
        *   `zR`: Open all folds.
        *   `zM`: Close all folds.

*   **`vim-fugitive` (Git Wrapper)**
    *   **Function:** `vim-fugitive` is a powerful Git wrapper for Neovim. It allows you to perform most Git operations (status, diff, commit, blame, push, pull, etc.) directly from within Neovim, without dropping to the terminal.
    *   **How to Use:** You interact with `vim-fugitive` primarily through its `:Git` command, followed by a Git subcommand (e.g., `:Git status`, `:Git diff`). While your configuration has commented out specific keymaps, you can still use the `:Git` command.
    *   **Example Commands (using `:Git`):**
        *   `:Git status`: Open a Git status window, showing modified, staged, and untracked files.
        *   `:Git diff`: View the Git diff for the current file.
        *   `:Git blame`: Show Git blame information for the current file.
        *   `:Git commit`: Open a commit message buffer.
        *   `:Git push`: Push changes to the remote repository.
        *   `:Git pull`: Pull changes from the remote repository.

*   **`vim-illuminate` (Word Illumination)**
    *   **Function:** This plugin automatically highlights other occurrences of the word under your cursor. This is useful for quickly seeing all instances of a variable, function, or keyword within the current file. It can use LSP, Treesitter, or regex for finding occurrences.
    *   **How to Use:** Simply move your cursor over a word, and `vim-illuminate` will highlight all other instances of that word in the current buffer.
    *   **Keymaps:** (No specific keymaps are associated with this plugin; it provides visual highlighting.)

*   **`flutter-bloc.nvim` (Flutter BLoC/Cubit Generator)**
    *   **Function:** This plugin provides commands to quickly generate Flutter BLoC (Business Logic Component) and Cubit boilerplate code. This is highly useful for Flutter developers who follow the BLoC pattern, as it automates the creation of common files and structures.
    *   **How to Use:** You use specific keymaps to trigger the creation of a BLoC or Cubit. When invoked, it will prompt you for the name of the BLoC/Cubit and generate the necessary files (e.g., `event.dart`, `state.dart`, `bloc.dart`).
    *   **Keymaps:**
        *   `<leader>cfb`: Create a new Flutter BLoC.
        *   `<leader>cfc`: Create a new Flutter Cubit.

*   **`flutter-hot-reload.lua` (Inactive Plugin)**
    *   **Function:** This file is currently commented out and does not configure any active plugin. It appears to be a placeholder or a configuration for a Flutter hot-reload plugin that was previously considered or used but is now inactive.
    *   **How to Use:** As it's inactive, there's no direct usage. If you intend to enable a Flutter hot-reload feature, you would need to uncomment and configure this plugin.
    *   **Keymaps:** (None, as the plugin is inactive.)

*   **`flutter-tools.nvim` (Flutter Development Tools)**
    *   **Function:** This plugin provides a comprehensive set of tools for Flutter development within Neovim. It integrates with the Flutter SDK to offer features like hot reload, hot restart, device management, DevTools integration, and LSP enhancements specific to Dart/Flutter.
    *   **How to Use:**
        *   **Automatic DevTools:** Your configuration automatically starts the DevTools server and opens it in your browser when you start a Flutter project.
        *   **Color Highlighting:** It shows derived colors for Dart variables, making it easier to visualize colors in your code.
        *   **Debugger Integration:** It integrates with `nvim-dap` for a seamless debugging experience.
    *   **Keymaps:** This plugin primarily provides commands that you would execute directly (e.g., `:FlutterRun`, `:FlutterHotReload`). While no specific keymaps are defined in your configuration for these commands, you can execute them directly.

*   **`dart-data-class-generator.nvim` (Dart Data Class Generation)**
    *   **Function:** This plugin automates the creation of boilerplate code for Dart data classes. It can generate constructors, `copyWith`, `toMap`/`fromMap`, equality operators, and `toString` methods.
    *   **How to Use:** The plugin works by providing LSP code actions. Place your cursor within a Dart class definition and use the code action keymap to see the available generators.
    *   **Keymaps:**
        *   `<leader>ca`: This existing keymap opens the code action menu. When used inside a Dart class, you will see options like "Generate `copyWith`", "Generate `toMap`", etc., provided by this plugin.

*   **`nvim-lspconfig` (LSP Client Configuration)**
    *   **Function:** `nvim-lspconfig` is the core plugin for configuring and managing Language Server Protocol (LSP) clients in Neovim. LSP clients provide features like auto-completion, go-to-definition, hover information, diagnostics, code actions, and refactoring, by communicating with language servers.
    *   **How to Use:** This plugin works by setting up various LSP servers for different programming languages. Once an LSP server is attached to a buffer (file), you can use the defined keymaps to interact with its features.
    *   **Keymaps:**
        *   `gr`: Show references for the symbol under the cursor.
        *   `gD`: Go to the declaration of the symbol under the cursor.
        *   `gd`: Go to the definition of the symbol under the cursor.
        *   `gi`: Show implementations of the symbol under the cursor.
        *   `gt`: Show type definitions for the symbol under the cursor (uses Telescope).
        *   `<leader>ca`: See available code actions (e.g., fix errors, refactor code). In visual mode, applies to the selection.
        *   `<leader>rn`: Smart rename (rename a symbol across your project).
        *   `<leader>D`: Show diagnostics for the current buffer (uses Telescope).
        *   `<leader>d`: Show diagnostics for the current line (in a floating window).
        *   `K`: Show documentation for the symbol under the cursor (hover information).
        *   `<leader>rs`: Restart the LSP server for the current buffer.

*   **`mason.nvim` (LSP and Tool Installer)**
    *   **Function:** `mason.nvim` is a Neovim plugin that simplifies the installation and management of LSP servers, DAP adapters, linters, and formatters. It acts as a central hub for these external tools, making it easy to get your development environment set up.
    *   **How to Use:**
        *   **Automatic Installation:** Your configuration automatically ensures that `lua_ls` (Lua Language Server) is installed.
        *   **Tool Installation:** It also ensures that `stylua` (Lua formatter) is installed.
        *   **Manual Management:** You can use Mason's commands (e.g., `:Mason`) to manually install, uninstall, or update LSP servers and other tools.
    *   **Keymaps:** (No specific keymaps are defined in your configuration for Mason itself, but you would use its commands directly.)

*   **`none-ls.nvim` (Null-LS / Language Server for Non-LSP Tools)**
    *   **Function:** `none-ls.nvim` (formerly `null-ls.nvim`) is a Neovim plugin that allows you to augment your LSP experience by integrating various command-line tools (formatters, linters, diagnostics tools) as virtual language servers. This means you can get features like on-the-fly linting and formatting from tools that don't have a native LSP server.
    *   **How to Use:** This plugin is currently **disabled** in your configuration (`enabled = false`). To use it, you would need to change `enabled = false` to `enabled = true` in its configuration file (`lua/martevol/plugins/lsp/none-ls.lua`). Once enabled, it will automatically run the configured tools (like `eslint_d` for diagnostics, `stylua` for Lua formatting, and `prettier` for general formatting) and display their output as if it were coming from an LSP server.
    *   **Keymaps:** (No specific keymaps are associated with this plugin; it works in the background to provide LSP-like features from external tools.)

*   **`neoscroll.lua` (Smooth Scrolling)**
    *   **Function:** This plugin provides smooth scrolling animations in Neovim, making cursor movements and jumps less jarring and easier to follow visually.
    *   **How to Use:** This plugin works automatically. When you perform actions that cause the screen to scroll (e.g., `C-d`, `C-u`, `gg`, `G`), you will observe a smooth scrolling animation instead of an instant jump.
    *   **Keymaps:** (No specific keymaps are associated with this plugin; it enhances visual scrolling.)

*   **`smear-cursor.nvim` (Cursor Smear Effect)**
    *   **Function:** This plugin adds a subtle "smear" or "trail" effect to your cursor as it moves, providing a visual cue for cursor movement. It's a purely aesthetic enhancement.
    *   **How to Use:** This plugin works automatically in the background. As you move your cursor around, you will observe the smear effect.
    *   **Keymaps:** (No specific keymaps are associated with this plugin; it provides a visual effect.)

*   **`incline.nvim` (Window Statusline/Titlebar)**
    *   **Function:** This plugin adds a customizable statusline or titlebar to the top right of your Neovim windows. It displays useful information such as the filename, a file type icon, and an indicator if the file has been modified.
    *   **How to Use:** This plugin works automatically once enabled. You will see the configured information displayed in the top right corner of your Neovim windows.
    *   **Keymaps:** (No specific keymaps are associated with this plugin; it provides visual information.)

*   **`conform.nvim` (Formatting)**
    *   `<leader>mm`: Format the current file or selected range (in visual mode).

*   **`gen.nvim` (AI Code Generation)**
    *   **Function:** Integrates large language models (LLMs) directly into Neovim, allowing you to interact with AI models for tasks like code generation, explanation, or refactoring. Your configuration specifies `deepseek-r1` as the default model.
    *   **How to Use:** You can invoke the AI chat session or select a different AI model using the defined keymaps. The output can be displayed in a split window.
    *   **Keymaps:**
        *   `<leader>G`: Start an AI chat session. This will open a new buffer where you can interact with the configured AI model.
        *   `<leader>Gg`: Select a different AI model to use for the chat session.


*   **`zoomer.lua` (User Function - Inactive)**
    *   **Function:** This file contains a commented-out Lua module that appears to implement a window "zoom" toggle functionality. When active, it would likely maximize the current window and then restore it to its previous size.
    *   **How to Use:** This module is currently **inactive** as its code is commented out. If it were active, the `M.zoom_toggle()` function would be called via a keymap.
    *   **Keymaps:** The commented-out keymap suggests it would have been triggered by `<leader>lll`.

## 3. General Usage Tips

*   **Leader Key**: Remember that your leader key is `<Space>`. Most custom keybindings will start with this.
*   **Which-Key**: When you press `<Space>` (or the start of a keybinding), `which-key.nvim` will display a popup showing available keybindings and their descriptions. This is very helpful for discovering and remembering commands.
*   **Treesitter**: Provides enhanced syntax highlighting and enables text objects for more precise selections and movements.
*   **LSP (Language Server Protocol)**: Your configuration includes `lspconfig.nvim` and `mason.nvim` for managing and configuring language servers, providing features like go-to-definition, hover information, and diagnostics.

This document should serve as a helpful reference for understanding and utilizing your Neovim configuration. If you have any specific questions about a particular plugin or feature, feel free to ask!
