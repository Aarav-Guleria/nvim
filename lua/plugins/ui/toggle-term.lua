return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      size = 20,
      open_mapping = [[<leader>T]],
      direction = "horizontal",
      shade_terminals = true,
      shading_factor = 2,
    })
  end,
  keys = {
    { "<leader>T", "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
  },
}
