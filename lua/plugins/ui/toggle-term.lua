return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      size = 20,
      open_mapping = [[<leader>tt]],
      direction = "horizontal",
      shade_terminals = true,
      shading_factor = 2,
    })
  end,
  keys = {
    { "<leader>tt", "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
  },
}
