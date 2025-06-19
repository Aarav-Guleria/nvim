return {
  {
    "folke/flash.nvim",
    enabled = true,
    event = "VeryLazy",
    opts = {
      modes = {
        search = {
          enabled = true, -- activate on `/` and `?`
        },
        char = {
          enabled = true, -- activates f/F/t/T
          keys = { "f", "F", "t", "T" },
        },
      },
      label = {
        rainbow = {
          enabled = true,
          highlight = { backdrop = true },
        },
      },
    },
    keys = {
      {
        "f",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash Jump",
      },
      {
        "F",
        mode = { "n", "x", "o" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
      {
        "<leader>r",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote Flash",
      },
      {
        "R",
        mode = { "o", "x" },
        function()
          require("flash").treesitter_search()
        end,
        desc = "Flash Treesitter Search",
      },
      {
        "z",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump({ mode = "char" })
        end,
        desc = "Flash f/F/t/T replacement",
      },
    },
  },
}
