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
      input = { enabled = true },
      quickfile = { enabled = true, exclude = { "latex" } },
      picker = {
        enabled = false,
        matchers = { frecency = true, cwd_bonus = false },
        formatters = {
          file = { filename_first = false, filename_only = false, icon_width = 2 },
        },
        layout = { preset = "telescope", cycle = false },
      },
      notifier = { enabled = false },
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

  -- Todo comments integration with Snacks pickers
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
          require("snacks").picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } })
        end,
        desc = "Todos: TODO/FIX/FIXME",
      },
    },
  },
}
