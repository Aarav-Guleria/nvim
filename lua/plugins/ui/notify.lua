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
        ERROR = "",
        WARN = "",
        INFO = "",
        DEBUG = "",
        TRACE = "✎",
      },
    })

    -- Make notify the global handler
    vim.notify = notify
  end,
}
