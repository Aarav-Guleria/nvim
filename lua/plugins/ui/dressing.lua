return {
  "stevearc/dressing.nvim",
  event = "VeryLazy",
  opts = {
    input = {
      enabled = true,
      default_prompt = "➤ ",
      title_pos = "center", -- can be "left", "center", or "right"
      insert_only = true,
      start_in_insert = true,
      border = "rounded",
      relative = "cursor",
      prefer_width = 40,
      win_options = {
        winblend = 10,
        winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
      },
      mappings = {
        n = { ["q"] = "Close", ["<Esc>"] = "Close" },
        i = { ["<Esc>"] = "Close", ["<C-c>"] = "Close", ["<CR>"] = "Confirm" },
      },
    },
    select = {
      enabled = true,
      backend = { "telescope", "fzf_lua", "fzf", "builtin" },
      trim_prompt = true,
      builtin = {
        border = "rounded",
        relative = "editor",
        win_options = {
          winblend = 10,
          winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
        },
      },
      telescope = {
        layout_strategy = "horizontal",
        layout_config = {
          width = 0.6,
          height = 0.4,
          prompt_position = "top",
        },
        sorting_strategy = "ascending",
      },
    },
  },
}
