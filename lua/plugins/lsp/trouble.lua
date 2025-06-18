return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = { "TroubleToggle", "Trouble" },
  keys = {
    { "<leader>xx", "<cmd>TroubleToggle<cr>", desc = "Toggle Trouble" },
    { "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>", desc = "Workspace Diagnostics" },
    { "<leader>xd", "<cmd>Trouble document_diagnostics<cr>", desc = "Document Diagnostics" },
  },
  config = function()
    require("trouble").setup({
      auto_open = false,
      auto_close = true,
      use_diagnostic_signs = true,
    })
  end,
}
