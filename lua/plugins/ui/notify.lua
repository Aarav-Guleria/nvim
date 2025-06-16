return {
  "rcarriga/nvim-notify",
  enable = false,
  lazy = false,
  config = function()
    local notify = require("notify")

    notify.setup({
      -- Animation & layout
      stages = "fade_in_slide_out",
      render = "compact",
      timeout = 2500,
      background_colour = "#1e1e2e",
      fps = 60,
      top_down = false,
      max_width = 60,
      minimum_width = 30,

      icons = {
        ERROR = "", -- nf-fa-times_circle
        WARN = "", -- nf-fa-exclamation_triangle
        INFO = "", -- nf-fa-info_circle
        DEBUG = "", -- nf-fa-bug
        TRACE = "✎", -- any symbol you like for trace
      },
    })

    -- Make notify the global handler
    vim.notify = notify
  end,
}
