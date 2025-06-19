return {
  "max397574/better-escape.nvim",
  event = "InsertEnter", -- load only in Insert mode
  opts = {
    mapping = { "jk" }, -- keys to trigger <Esc>
    timeout = 300, -- time in ms to wait for second key
    keys = "<Esc>", -- keys to send on escape
  },
}
