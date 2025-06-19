return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
    preset = "modern", -- or "classic", "modern", "helix"
    plugins = {
      marks = true, -- shows a list of your marks on ' and `
      registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
      spelling = {
        enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
        suggestions = 20,
      },
    },
    -- Key mappings
    replace = {
      key = {
        { "<space>", "SPC" },
        { "<cr>", "RET" },
        { "<tab>", "TAB" },
      },
    },
    icons = {
      breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
      separator = "➜", -- symbol used between a key and it's label
      group = "+", -- symbol prepended to a group
      ellipsis = "…",
      mappings = true, -- set to false to disable all mapping icons
      rules = false, -- use the default rules from `require("which-key.plugins.presets")`
    },
    keys = {
      scroll_down = "<c-d>", -- scroll down in the popup
      scroll_up = "<c-u>", -- scroll up in the popup
    },
    -- Window/popup configuration
    win = {
      border = "rounded", -- none, single, double, shadow, rounded
      padding = { 1, 2, 1, 2 }, -- extra window padding [top, right, bottom, left]
      zindex = 1000, -- positive value to position WhichKey above other floating windows
    },
    layout = {
      height = { min = 4, max = 25 }, -- min and max height of the columns
      width = { min = 20, max = 50 }, -- min and max width of the columns
      spacing = 3, -- space between columns
      align = "left", -- align columns left, center or right
    },
    show_help = true, -- show a help message in the command line for using WhichKey
    show_keys = true, -- show the currently pressed key and its label as a message in the command line
    triggers = {
      "<leader>",
      mode = { "n", "x", "o" },
    },

    defer = function()
      return { gc = "Comments" }
    end,
  },
  config = function(_, opts)
    -- Force WhichKey to always show root group on <leader> press
    vim.keymap.set({ "x", "o" }, "<leader>", function()
      vim.schedule(function()
        require("which-key").show("", { mode = vim.api.nvim_get_mode().mode })
      end)
    end, { noremap = true, silent = true })

    local wk = require("which-key")
    wk.setup(opts)

    -- Leader key mappings using the new spec format
    wk.add({
      -- General
      { "<leader>e", ":Neotree toggle<CR>", desc = "Toggle File Explorer" },
      { "<leader>w", ":w<CR>", desc = "Write/Save File" },
      { "<leader>q", ":qa<CR>", desc = "Quit All" },
      { "<leader>D", [["_d]], desc = "Delete without yanking" },
      { "<leader>x", "<cmd>!chmod +x %<CR>", desc = "Make file executable" },
      { "<leader><esc>", ":noh<CR>", desc = "Clear search highlight" },
      { "<leader>p", [["_dP]], desc = "Paste over selection", mode = "x" },

      -- Buffers
      { "<leader>b", group = "Buffers" },
      { "<leader>bd", ":bdelete<CR>", desc = "Delete buffer" },
      { "<leader>bN", ":enew<CR>", desc = "New buffer" },

      -- Splits
      { "<leader>s", group = "Splits" },
      { "<leader>sv", "<C-w>v", desc = "Split window vertically" },
      { "<leader>sh", "<C-w>s", desc = "Split window horizontally" },
      { "<leader>se", "<C-w>=", desc = "Equalize splits" },
      { "<leader>sx", "<cmd>close<CR>", desc = "Close split" },
      { "<leader>sm", "<cmd>MaximizerToggle<CR>", desc = "Maximize/minimize a split" },

      -- Find (Telescope)
      { "<leader>f", group = "Find" },
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Find Help" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Find Recent Files" },
      { "<leader>fc", "<cmd>Telescope commands<cr>", desc = "Find Commands" },
      { "<leader>fe", "<cmd>Telescope file_browser<cr>", desc = "File Browser" },
      { "<leader>fu", "<cmd>Telescope undo<cr>", desc = "Undo Tree" },
      { "<leader>fp", "<cmd>Telescope project<cr>", desc = "Projects" },
      { "<leader>fs", "<cmd>Telescope session-lens search_session<cr>", desc = "Find Sessions" },
      { "<leader>ft", "<cmd>Telescope harpoon marks<cr>", desc = "Harpoon Marks" },
      { "<leader>fcc", "<cmd>Telescope git_commits<cr>", desc = "Git Commits" },

      -- Treesitter
      { "<leader>u", group = "Treesitter" },
      { "<leader>ui", "<cmd>InspectTree<cr>", desc = "Inspect Treesitter Tree" },

      -- Git
      { "<leader>g", group = "Git" },
      { "<leader>gg", ":Git<CR>", desc = "Open Git status" },
      { "<leader>gc", ":Git commit<CR>", desc = "Git commit" },
      { "<leader>gb", ":Git branch<CR>", desc = "Git branch" },
      { "<leader>gP", ":Git push --quiet<CR>", desc = "Git Push (Fugitive)" },
      { "<leader>gp", ":Git pull --rebase --quiet<CR>", desc = "Git Pull (Fugitive)" },
      { "<leader>gs", group = "Gitsigns" },
      { "<leader>gss", ":Gitsigns stage_hunk<CR>", desc = "Stage hunk" },
      { "<leader>gsr", ":Gitsigns reset_hunk<CR>", desc = "Reset hunk" },
      { "<leader>gsb", ":Gitsigns stage_buffer<CR>", desc = "Stage buffer" },
      { "<leader>gsR", ":Gitsigns reset_buffer<CR>", desc = "Reset buffer" },
      { "<leader>gsu", ":Gitsigns undo_stage_hunk<CR>", desc = "Undo stage hunk" },
      { "<leader>gsp", ":Gitsigns preview_hunk<CR>", desc = "Preview hunk" },
      {
        "<leader>gsbl",
        function()
          require("gitsigns").blame_line({ full = true })
        end,
        desc = "Blame line",
      },
      { "<leader>gsB", ":Gitsigns toggle_current_line_blame<CR>", desc = "Toggle line blame" },
      { "<leader>gsd", ":Gitsigns diffthis<CR>", desc = "Diff this" },
      {
        "<leader>gsD",
        function()
          require("gitsigns").diffthis("~")
        end,
        desc = "Diff this ~",
      },
      { "<leader>gS", "<cmd>Telescope git_status<cr>", desc = "Git Status" },
      { "<leader>gl", "<cmd>LazyGit<CR>", desc = "Open LazyGit" },
      { "<leader>gt", ":Git push -u origin ", desc = "Set Upstream (Fugitive)" },

      -- LSP
      { "<leader>c", group = "Code" },
      { "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action" },
      { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions (Trouble)",
      },
      { "<leader>ct", "<cmd>ColorizerToggle<cr>", desc = "Toggle Colorizer" },
      { "<leader>cr", "<cmd>ColorizerReloadAllBuffers<cr>", desc = "Reload Colorizer" },

      -- Harpoon
      { "<leader>h", group = "Harpoon" },
      {
        "<leader>ha",
        function()
          require("harpoon"):list():add()
        end,
        desc = "Add file to harpoon",
      },
      {
        "<leader>hh",
        function()
          require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
        end,
        desc = "Toggle Harpoon UI",
      },
      { "<leader>ht", "<cmd>Telescope harpoon marks<cr>", desc = "Show Harpoon Marks" },

      -- Package Info
      { "<leader>n", group = "NPM Scripts" },
      {
        "<leader>ns",
        function()
          require("package-info").show()
        end,
        desc = "Show package versions",
      },
      {
        "<leader>nc",
        function()
          require("package-info").hide()
        end,
        desc = "Hide package versions",
      },
      {
        "<leader>nt",
        function()
          require("package-info").toggle()
        end,
        desc = "Toggle package versions",
      },
      {
        "<leader>nu",
        function()
          require("package-info").update()
        end,
        desc = "Update package",
      },
      {
        "<leader>nd",
        function()
          require("package-info").delete()
        end,
        desc = "Delete package",
      },
      {
        "<leader>ni",
        function()
          require("package-info").install()
        end,
        desc = "Install package",
      },
      {
        "<leader>np",
        function()
          require("package-info").change_version()
        end,
        desc = "Change package version",
      },

      -- Live Server
      { "<leader>l", group = "Live Server" },
      { "<leader>ls", "<cmd>LiveServer<cr>", desc = "Start live server" },
      { "<leader>lS", "<cmd>LiveServerStop<cr>", desc = "Stop live server" },

      -- Debugging (DAP)
      { "<leader>d", group = "Debug" },
      {
        "<leader>dc",
        function()
          require("dap").continue()
        end,
        desc = "Continue",
      },
      {
        "<leader>dC",
        function()
          require("dap").run_to_cursor()
        end,
        desc = "Run to Cursor",
      },
      {
        "<leader>dd",
        function()
          require("dap").disconnect()
        end,
        desc = "Disconnect",
      },
      {
        "<leader>dg",
        function()
          require("dap").session()
        end,
        desc = "Get Session",
      },
      {
        "<leader>di",
        function()
          require("dap").step_into()
        end,
        desc = "Step Into",
      },
      {
        "<leader>do",
        function()
          require("dap").step_over()
        end,
        desc = "Step Over",
      },
      {
        "<leader>dp",
        function()
          require("dap").pause()
        end,
        desc = "Pause",
      },
      {
        "<leader>dr",
        function()
          require("dap").repl.toggle()
        end,
        desc = "Toggle REPL",
      },
      {
        "<leader>ds",
        function()
          require("dap").session()
        end,
        desc = "Session",
      },
      {
        "<leader>dt",
        function()
          require("dap").terminate()
        end,
        desc = "Terminate",
      },
      {
        "<leader>dl",
        function()
          require("dap").run_last()
        end,
        desc = "Run Last",
      },
      {
        "<leader>dw",
        function()
          require("dapui").toggle()
        end,
        desc = "Toggle DAP UI",
      },
      {
        "<leader>de",
        function()
          require("dapui").eval()
        end,
        desc = "Eval",
        mode = { "n", "v" },
      },
      {
        "<leader>du",
        function()
          require("dapui").toggle({ layout = 1 })
        end,
        desc = "Toggle Sidebar",
      },
      {
        "<leader>dU",
        function()
          require("dapui").toggle({ layout = 2 })
        end,
        desc = "Toggle Console",
      },
      {
        "<leader>dL",
        function()
          require("dap").list_breakpoints()
        end,
        desc = "List Breakpoints",
      },
      {
        "<leader>dk",
        function()
          require("dap").up()
        end,
        desc = "Up",
      },
      {
        "<leader>dj",
        function()
          require("dap").down()
        end,
        desc = "Down",
      },
      {
        "<leader>dh",
        function()
          require("dap.ui.widgets").hover()
        end,
        desc = "Hover Variables",
      },
      {
        "<leader>dS",
        function()
          local widgets = require("dap.ui.widgets")
          widgets.centered_float(widgets.scopes)
        end,
        desc = "Scopes",
      },
      {
        "<leader>db",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Toggle Breakpoint",
      },
      {
        "<leader>dB",
        function()
          require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end,
        desc = "Conditional Breakpoint",
      },
      {
        "<leader>dlp",
        function()
          require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
        end,
        desc = "Log Point",
      },

      -- Search/Replace
      { "<leader>S", "<cmd>Spectre<cr>", desc = "Search/Replace in Project" },
      {
        "<leader>sw",
        function()
          require("spectre").open_visual({ select_word = true })
        end,
        desc = "Search/Replace current word",
      },
      {
        "<leader>sp",
        function()
          require("spectre").open_file_search({ select_word = true })
        end,
        desc = "Search/Replace current file",
      },

      -- TypeScript
      { "<leader>t", group = "TypeScript" },
      { "<leader>to", "<cmd>TSToolsOrganizeImports<cr>", desc = "Organize Imports" },
      { "<leader>ts", "<cmd>TSToolsSortImports<cr>", desc = "Sort Imports" },
      { "<leader>tu", "<cmd>TSToolsRemoveUnused<cr>", desc = "Remove Unused" },
      { "<leader>td", "<cmd>TSToolsGoToSourceDefinition<cr>", desc = "Go to Source Definition" },
      { "<leader>tf", "<cmd>TSToolsFixAll<cr>", desc = "Fix All" },

      -- Trouble
      { "<leader>x", group = "Trouble" },
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics" },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List" },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List" },
      {
        "<leader>xw",
        "<cmd>Trouble diagnostics toggle filter.severity=vim.diagnostic.severity.WARN<cr>",
        desc = "Warnings",
      },
      {
        "<leader>xe",
        "<cmd>Trouble diagnostics toggle filter.severity=vim.diagnostic.severity.ERROR<cr>",
        desc = "Errors",
      },

      -- Format
      { "<leader>m", group = "Format" },
      {
        "<leader>mp",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        desc = "Format buffer",
        mode = { "n", "v" },
      },
      {
        "<leader>mm",
        function()
          vim.lsp.buf.format({ async = true })
        end,
        desc = "Format Code",
      },

      -- Rename
      { "<leader>r", group = "Rename" },
      { "<leader>rn", vim.lsp.buf.rename, desc = "Rename Symbol" },

      -- LSP Workspace
      { "<leader>wa", vim.lsp.buf.add_workspace_folder, desc = "Add Workspace Folder" },
      { "<leader>wr", vim.lsp.buf.remove_workspace_folder, desc = "Remove Workspace Folder" },
      { "<leader>ws", "<cmd>Telescope lsp_workspace_symbols<cr>", desc = "Workspace Symbols" },
    })

    -- Local leader mappings
    wk.add({
      { "<localleader>r", group = "REST" },
      { "<localleader>rr", "<cmd>Rest run<cr>", desc = "Run REST request" },
      { "<localleader>rl", "<cmd>Rest run last<cr>", desc = "Re-run last REST request" },
      { "<localleader>rp", "<cmd>Rest run<cr>", desc = "Preview REST request" },
      { "<localleader>re", "<cmd>Rest env show<cr>", desc = "Show environment variables" },
      { "<localleader>rs", "<cmd>Rest env select<cr>", desc = "Select environment" },
    })

    -- Harpoon mappings
    wk.add({
      {
        ",1",
        function()
          require("harpoon"):list():select(1)
        end,
        desc = "Go to file 1",
      },
      {
        ",2",
        function()
          require("harpoon"):list():select(2)
        end,
        desc = "Go to file 2",
      },
      {
        ",3",
        function()
          require("harpoon"):list():select(3)
        end,
        desc = "Go to file 3",
      },
      {
        ",4",
        function()
          require("harpoon"):list():select(4)
        end,
        desc = "Go to file 4",
      },
    })

    -- Direct mappings for normal mode
    wk.add({
      {
        "[d",
        function()
          vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
        end,
        desc = "Previous Error",
      },
      {
        "[w",
        function()
          vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARN })
        end,
        desc = "Previous Warning",
      },
      {
        "]d",
        function()
          vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
        end,
        desc = "Next Error",
      },
      {
        "]w",
        function()
          vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN })
        end,
        desc = "Next Warning",
      },
      {
        "[h",
        function()
          require("gitsigns").prev_hunk()
        end,
        desc = "Previous Hunk",
      },
      {
        "]h",
        function()
          require("gitsigns").next_hunk()
        end,
        desc = "Next Hunk",
      },
      { "<C-a>h", desc = "Tmux Navigate Left" },
      { "<C-a>j", desc = "Tmux Navigate Down" },
      { "<C-a>k", desc = "Tmux Navigate Up" },
      { "<C-a>l", desc = "Tmux Navigate Right" },
      { "gcc", desc = "Comment Line" },
      { "gbc", desc = "Comment Block" },
      { "gd", vim.lsp.buf.definition, desc = "LSP Definition" },
      { "gD", vim.lsp.buf.declaration, desc = "LSP Declaration" },
      { "gi", vim.lsp.buf.implementation, desc = "LSP Implementation" },
      { "go", vim.lsp.buf.type_definition, desc = "LSP Type Definition" },
      { "gr", vim.lsp.buf.references, desc = "LSP References" },
      { "gs", vim.lsp.buf.signature_help, desc = "LSP Signature Help" },
      { "K", vim.lsp.buf.hover, desc = "LSP Hover" },
    })

    -- Direct mappings for normal, visual, and operator-pending modes
    wk.add({
      {
        "f",
        function()
          require("flash").jump()
        end,
        desc = "Flash Jump",
        mode = { "n", "x", "o" },
      },
      {
        "F",
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
        mode = { "n", "x", "o" },
      },
      {
        "z",
        function()
          require("flash").jump({ mode = "char" })
        end,
        desc = "Flash Char Jump",
        mode = { "n", "x", "o" },
      },
    })

    -- Direct mappings for operator and visual modes
    wk.add({
      {
        "R",
        function()
          require("flash").treesitter_search()
        end,
        desc = "Flash Treesitter Search",
        mode = { "o", "x" },
      },
      { "ih", ":<C-U>Gitsigns select_hunk<CR>", desc = "Select Hunk", mode = { "o", "x" } },
    })

    -- Direct mappings for normal and visual modes
    wk.add({
      { "<C-z>,", desc = "Emmet Expand", mode = { "n", "v" } },
    })
  end,
}
