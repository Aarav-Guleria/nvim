return {
  {
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      styles = {
        input = {
          keys = {
            n_esc = { "<C-c>", { "cmp_close", "cancel" }, mode = "n", expr = true },
            i_esc = { "<C-c>", { "cmp_close", "stopinsert" }, mode = "i", expr = true },
          },
        },
      },
      input = { enabled = false }, --conflict with dressing.nvim
      quickfile = {
        enabled = true,
        exclude = { "latex" },
      },
      picker = {
        enabled = true,
        matchers = {
          frecency = true,
          cwd_bonus = false,
        },
        formatters = {
          file = {
            filename_first = true,
            filename_only = false,
            icon_width = 2,
          },
        },
        layout = {
          preset = "telescope", --Use telescope layout style
          cycle = false,
        },
      },
      notifier = {
        enabled = true,
        timeout = 3000,
        width = { min = 40, max = 0.4 },
        height = { min = 1, max = 0.6 },
        margin = { top = 0, right = 1, bottom = 0 },
        padding = true,
        sort = { "level", "added" },
        level = vim.log.levels.TRACE,
        icons = {
          error = " ",
          warn = " ",
          info = " ",
          debug = " ",
          trace = " ",
        },
      },
    },
    config = function(_, opts)
      local ok, snacks = pcall(require, "snacks")
      if not ok then
        return
      end
      vim.schedule(function()
        snacks.setup(opts)
        if opts.input.enabled then
          vim.ui.input = snacks.input
        end
      end)
    end,
  },

  -- 📝 Optional Todo picker using snacks
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPre", "BufNewFile" },
    optional = true,
    keys = {
      {
        "<leader>pt",
        function()
          require("snacks").picker.todo_comments()
        end,
        desc = "Todos (All)",
      },
      {
        "<leader>pT",
        function()
          require("snacks").picker.todo_comments({
            keywords = { "TODO", "FIX", "FIXME" },
          })
        end,
        desc = "Todos: TODO/FIX/FIXME",
      },
    },
  },
}
