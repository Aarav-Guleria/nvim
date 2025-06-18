return {
  "nvim-pack/nvim-spectre",
  keys = {
    { "<leader>S", "<cmd>Spectre<cr>", desc = "Search/Replace in Project" },
    {
      "<leader>sw",
      function()
        require("spectre").open_visual({ select_word = true })
      end,
      desc = "Search/Replace current word",
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
