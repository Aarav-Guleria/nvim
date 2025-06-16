return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope", -- Lazy load on command
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-telescope/telescope-file-browser.nvim",
      "debugloop/telescope-undo.nvim",
      "nvim-telescope/telescope-project.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      telescope.setup({
        defaults = {
          prompt_prefix = " ",
          selection_caret = " ",
          path_display = { "smart" },
          file_ignore_patterns = { "%.git/", "node_modules/", "%.cache/" },
          mappings = {
            i = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
              ["<C-u>"] = false, -- Clear prompt
            },
            n = {
              ["q"] = actions.close,
            },
          },
          layout_config = {
            horizontal = { preview_width = 0.6 },
            vertical = { preview_height = 0.6 },
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
          undo = {
            side_by_side = true,
            layout_strategy = "vertical",
            layout_config = { preview_height = 0.8 },
          },
          project = {
            base_dirs = { "~/projects", "~/work" }, -- Add more base dirs if needed
            hidden_files = true,
          },
          file_browser = {
            theme = "dropdown",
            hijack_netrw = true,
          },
          -- Session lens configuration
          ["session-lens"] = {
            prompt_title = "Sessions",
            path_display = { "shorten" },
            theme_conf = {
              border = true,
              layout_config = {
                width = 0.8,
                height = 0.6,
              },
            },
            previewer = false,
            mappings = {
              i = {
                ["<C-d>"] = require("auto-session.session-lens").delete_session,
              },
            },
          },
        },
      })
      -- Load extensions
      telescope.load_extension("fzf")
      telescope.load_extension("file_browser")
      telescope.load_extension("undo")
      telescope.load_extension("project")

      -- Load session-lens extension
      pcall(telescope.load_extension, "session-lens")

      -- Safe loading for optional extensions
      pcall(telescope.load_extension, "notify")
      pcall(telescope.load_extension, "noice")
    end,
    keys = {
      -- Core telescope pickers
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
      { "<leader>fc", "<cmd>Telescope commands<cr>", desc = "Commands" },
      -- Extension pickers
      { "<leader>fe", "<cmd>Telescope file_browser<cr>", desc = "File Browser" },
      { "<leader>fu", "<cmd>Telescope undo<cr>", desc = "Undo Tree" },
      { "<leader>fp", "<cmd>Telescope project<cr>", desc = "Projects" },
      { "<leader>fs", "<cmd>Telescope session-lens search_session<cr>", desc = "Find Sessions" },
      -- Git integration
      { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Git Commits" },
      { "<leader>gS", "<cmd>Telescope git_status<cr>", desc = "Git Status" },
      -- LSP integration
      { "<leader>lr", "<cmd>Telescope lsp_references<cr>", desc = "LSP References" },
      { "<leader>ld", "<cmd>Telescope lsp_definitions<cr>", desc = "LSP Definitions" },
      { "<leader>li", "<cmd>Telescope lsp_implementations<cr>", desc = "LSP Implementations" },
      { "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols" },
    },
  },
}
