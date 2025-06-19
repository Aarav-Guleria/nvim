return {
  "barrett-ruth/live-server.nvim",
  build = "npm install -g live-server",
  cmd = { "LiveServer" },
  keys = {
    { "<leader>ls", "<cmd>LiveServer<cr>", desc = "Start live server" },
    { "<leader>lS", "<cmd>LiveServerStop<cr>", desc = "Stop live server" },
  },
}
