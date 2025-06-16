return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local lualine = require("lualine")
    local lazy_status = require("lazy.status")

    local colors = {
      color0 = "#1e1e2e",
      normal_bg = "#7e9cd8", -- blue
      insert_bg = "#98bb6c", -- green
      visual_bg = "#ae81ff", -- purple
      replace_bg = "#ff5874", -- red
      inactive_bg = "#1c1e26",
      fg = "#c3ccdc",
      faded = "#828697",
    }

    local theme = {
      normal = {
        a = { fg = colors.color0, bg = colors.normal_bg, gui = "bold" },
        b = { fg = colors.fg, bg = colors.inactive_bg },
        c = { fg = colors.fg, bg = colors.inactive_bg },
      },
      insert = {
        a = { fg = colors.color0, bg = colors.insert_bg, gui = "bold" },
        b = { fg = colors.fg, bg = colors.inactive_bg },
        c = { fg = colors.fg, bg = colors.inactive_bg },
      },
      visual = {
        a = { fg = colors.color0, bg = colors.visual_bg, gui = "bold" },
        b = { fg = colors.fg, bg = colors.inactive_bg },
        c = { fg = colors.fg, bg = colors.inactive_bg },
      },
      replace = {
        a = { fg = colors.color0, bg = colors.replace_bg, gui = "bold" },
        b = { fg = colors.fg, bg = colors.inactive_bg },
        c = { fg = colors.fg, bg = colors.inactive_bg },
      },
      inactive = {
        a = { fg = colors.faded, bg = colors.inactive_bg, gui = "bold" },
        b = { fg = colors.faded, bg = colors.inactive_bg },
        c = { fg = colors.faded, bg = colors.inactive_bg },
      },
    }

    local mode = {
      "mode",
      fmt = function(str)
        return " " .. str
      end,
    }

    local branch = {
      "branch",
      icon = { "", color = { fg = "#A6D4DE" } },
    }

    local diff = {
      "diff",
      colored = true,
      symbols = { added = " ", modified = " ", removed = " " },
    }

    local filename = {
      "filename",
      file_status = true,
      path = 0,
    }

    local updates = {
      function()
        return lazy_status.updates()
      end,
      cond = lazy_status.has_updates,
      color = { fg = "#ff9e64" },
    }

    lualine.setup({
      options = {
        theme = theme,
        icons_enabled = true,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = { mode },
        lualine_b = { branch, diff },
        lualine_c = { filename },
        lualine_x = {
          updates,
          "fileformat", --  /  / 
          "filetype",   --  for Lua, etc.
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { filename },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {},
    })
  end,
}

