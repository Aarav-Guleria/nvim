return {
  "stevearc/oil.nvim",
  enabled = false,
  dependdencies = {
    "nvim-tree/nvim-web-devicons",
    "nvim-telescope/telescope.nvim",
  },

  config = function()
    require("oil").setup()
    require("telescope").load.extension("oil")
  end,

  opts = {
    default_file_explorer = true,
    columns = {
      "icon", -- You can also add "permissions", "size", "mtime"
    },
    buf_options = {
      buflisted = false,
      bufhidden = "hide",
    },
    win_options = {
      wrap = false,
      signcolumn = "yes",
      cursorcolumn = false,
      foldcolumn = "0",
      spell = false,
      list = false,
      conceallevel = 3,
      concealcursor = "nvic",
    },
    delete_to_trash = true, -- Moves deleted files to trash
    skip_confirm_for_simple_edits = true,
    view_options = {
      show_hidden = true,
    },
    keymaps = {
      ["<CR>"] = "actions.select", -- Open file/directory
      ["<C-v>"] = "actions.select_vsplit", -- Open in vertical split
      ["<C-s>"] = "actions.select_split", -- Open in horizontal split
      ["<C-t>"] = "actions.select_tab", -- Open in new tab
      ["-"] = "actions.parent", -- Go to parent dir
      ["<BS>"] = "actions.parent", -- Alt key for parent
      ["q"] = "actions.close", -- Close Oil
      ["<leader>r"] = "actions.refresh", -- Refresh
      ["g?"] = "actions.show_help", -- Help
    },
    float = {
      padding = 2,
      max_width = 100,
      max_height = 30,
      border = "rounded",
      win_options = {
        winblend = 0,
      },
    },
    preview = {
      border = "rounded",
      max_width = 0.9,
      max_height = 0.7,
      wrap = false,
      win_options = {
        winblend = 0,
      },
    },
    use_default_keymaps = false,
  },
  keys = {
    { "<leader>o", "<cmd>Oil<CR>", desc = "Open Oil file explorer" },
  },
}
