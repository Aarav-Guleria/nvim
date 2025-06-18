return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
    plugins = {
      marks = true, -- shows a list of your marks on ' and `
      registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
      spelling = {
        enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
        suggestions = 20,
      },
      -- the presets plugin, adds help for a bunch of default keybindings in Neovim
      -- No actual key bindings are created
      presets = {
        operators = false, -- adds help for operators like d, y, ...
        motions = false, -- adds help for motions
        text_objects = false, -- help for text objects triggered after entering an operator
        windows = true, -- default bindings on <c-w>
        nav = true, -- misc bindings to work with windows
        z = true, -- bindings for folds, spelling and wrapping
        g = true, -- bindings for code navigation, git, ...
      },
    },
    -- add operators that will trigger which-key in visual mode
    defer = {
      ["gc"] = "Comments",
    },
    icons = {
      breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
      separator = "➜", -- symbol used between a key and its description
      group = "+", -- symbol prepended to a group description
    },
    win = {
      border = "rounded", -- none, single, double, shadow
      -- REMOVED: position = "bottom", -- This key is no longer valid
      -- REMOVED: margin = { 1, 0, 1, 0 }, -- This key is no longer valid
      padding = { 2, 2, 2, 2 }, -- top, right, bottom, left
    },
    layout = {
      height = { min = 4, max = 25 }, -- min and max height of the columns
      width = { min = 20, max = 50 }, -- min and max width of the columns
      spacing = 3, -- space between columns
      align = "left", -- align columns left, center or right
    },
    filter = function()
      return true -- always allow all keys
    end,
    replace = {
      patterns = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
    },
    show_help = true, -- show help message on the command line when the popup is visible
    triggers = { "<auto>" },
    disable = {
      i = { "j", "k" },
      v = { "j", "k" },
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    -- Use the new which-key v3 spec format
    wk.add({
      { "<leader>b", group = "Buffer/Breakpoint" },
      { "<leader>bN", "<cmd>enew<CR>", desc = "New Buffer" },
      { "<leader>bd", "<cmd>bdelete<CR>", desc = "Delete Buffer" },
      { "<leader>c", group = "Code/Completion" },
      { "<leader>ca", desc = "Code Action", mode = { "n", "v" } },
      { "<leader>d", group = "Debug/Delete" },
      { "<leader>db", desc = "Toggle Breakpoint" },
      { "<leader>dB", desc = "Conditional Breakpoint" },
      { "<leader>dw", desc = "Toggle DAP UI" },
      { "<leader>e", "<cmd>Neotree toggle<CR>", desc = "Explorer" },
      { "<leader>f", group = "File/Find/Format" },
      { "<leader>ff", desc = "Find Files" },
      { "<leader>fg", desc = "Live Grep" },
      { "<leader>fb", desc = "Buffers" },
      { "<leader>fr", desc = "Recent Files" },
      { "<leader>fh", desc = "Help Tags" },
      { "<leader>fp", desc = "Projects" },
      { "<leader>fm", desc = "Format Code" },
      { "<leader>g", group = "Git" },
      { "<leader>gg", desc = "Open Fugitive (Git Status)" },
      { "<leader>gS", desc = "Git Status (Telescope)" },
      { "<leader>gc", desc = "Git Commits (Telescope)" },
      { "<leader>gs", group = "Stage" },
      { "<leader>gs_", desc = "Stage Hunk" },
      { "<leader>gsb", desc = "Stage Buffer" },
      { "<leader>gr", group = "Reset" },
      { "<leader>gr_", desc = "Reset Hunk" },
      { "<leader>gp", desc = "Preview Hunk" },
      { "<leader>gb", group = "Blame" },
      { "<leader>gbl", desc = "Blame Line" },
      { "<leader>gu", desc = "Undo Stage" },
      { "<leader>h", group = "Harpoon" },
      { "<leader>ha", desc = "Add file" },
      { "<leader>hh", desc = "Toggle Menu" },
      { "<leader>l", group = "Lazy/LSP" },
      { "<leader>lg", desc = "LazyGit" },
      { "<leader>lr", group = "REST" },
      { "<leader>lre", desc = "Restart ESLint" },
      { "<leader>q", "<cmd>qa<CR>", desc = "Quit All" },
      { "<leader>r", group = "Rename" },
      { "<leader>rn", desc = "Rename Symbol" },
      { "<leader>s", group = "Session/Split/Search" },
      { "<leader>ss", desc = "Save Session" },
      { "<leader>sr", desc = "Restore Session" },
      { "<leader>sl", desc = "List Sessions" },
      { "<leader>sd", desc = "Delete Session" },
      { "<leader>sv", desc = "Split Vertically" },
      { "<leader>sh", desc = "Split Horizontally" },
      { "<leader>sx", desc = "Close Split" },
      { "<leader>se", desc = "Equalize Splits" },
      { "<leader>sm", desc = "Maximize Split" },
      { "<leader>sS", "<cmd>Spectre<CR>", desc = "Search/Replace Project" },
      { "<leader>sw", desc = "Search/Replace Word" },
      { "<leader>t", group = "Toggle/Terminal" },
      { "<leader>tt", desc = "Toggle Terminal" },
      { "<leader>u", "<cmd>UndotreeToggle<CR>", desc = "Undo Tree" },
      { "<leader>w", "<cmd>w<CR>", desc = "Write File" },
      { "<leader>x", desc = "Make Executable" },
    })
  end,
}
