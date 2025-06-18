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
        },
      },
    },
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash Jump",
      },
      {
        "S",
        mode = { "n", "x", "o" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
      {
        "<leader>fr",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote Flash",
      },
      {
        "r",
        mode = { "o", "x" },
        function()
          require("flash").treesitter_search()
        end,
        desc = "Flash Treesitter Search",
      },
    },
  },
}
