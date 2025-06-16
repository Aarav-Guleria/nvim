local theme = require("current-theme")

-- Delay applying theme until Lazy is done loading
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    vim.cmd.colorscheme(theme.name)
    vim.opt.background = theme.background or "dark"
  end,
})

