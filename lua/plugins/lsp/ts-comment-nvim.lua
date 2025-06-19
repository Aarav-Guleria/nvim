-- Modern alternative to Comment.nvim + nvim-ts-context-commentstring
return {
  "folke/ts-comments.nvim",
  opts = {},
  event = "VeryLazy",
  enabled = vim.fn.has("nvim-0.10.0") == 1,
}
