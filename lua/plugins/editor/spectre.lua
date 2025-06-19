return {
  "nvim-pack/nvim-spectre",
  cmd = "Spectre",

  keys = {

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
  },

  opts = {
    live_update = true,
    highlight = {
      ui = "String",
      search = "DiffChange",
      replace = "DiffAdd",
    },
  },
}
