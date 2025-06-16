return {
  "joshuavial/aider.nvim",
  dependencies = {
    "akinsho/toggleterm.nvim",
  },
  config = function()
    require("aider").setup({
      -- Optional configuration options
    })
  end,
}
