local current = require("current-theme").name

return {
  --Catppuccin
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = current ~= "catppuccin",
    priority = current == "catppuccin" and 1000 or nil,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        background = { dark = "mocha" },
        transparent_background = true,
        integrations = {
          treesitter = true,
          cmp = true,
          gitsigns = true,
          telescope = true,
          neotree = true,
          dap = true,
          mason = true,
          notify = false,
          mini = true,
          flash = true,
          noice = true,
          snacks = true,
          bufferline = true,
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { "italic" },
              hints = { "italic" },
              warnings = { "italic" },
              information = { "italic" },
            },
            underlines = {
              errors = { "underline" },
              hints = { "underline" },
              warnings = { "underline" },
              information = { "underline" },
            },
          },
        },
      })
    end,
  },

  -- 🌹 Rose Pine
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = current ~= "rose-pine",
    priority = current == "rose-pine" and 1000 or nil,
    config = function()
      require("rose-pine").setup({
        variant = "main",
        dark_variant = "main",
        styles = {
          bold = true,
          italic = false,
          transparency = false,
        },
        highlight_groups = {
          Normal = { bg = "none" },
          Pmenu = { fg = "#e0def4" },
          PmenuSel = { bg = "#4a465d", fg = "#f8f5f2" },
        },
        enable = {
          terminal = false,
          legacy_highlights = false,
          migrations = true,
        },
      })
    end,
  },

  -- 🤤 Gruvbox
  {
    "ellisonleao/gruvbox.nvim",
    name = "gruvbox",
    lazy = current ~= "gruvbox",
    priority = current == "gruvbox" and 1000 or nil,
    config = function()
      require("gruvbox").setup({
        terminal_colors = true,
        bold = true,
        italic = { comments = false },
        inverse = true,
        transparent_mode = false,
        overrides = { Pmenu = { bg = "" } },
      })
    end,
  },

  -- 🍃 Kanagawa
  {
    "rebelot/kanagawa.nvim",
    name = "kanagawa",
    lazy = current ~= "kanagawa",
    priority = current == "kanagawa" and 1000 or nil,
    config = function()
      require("kanagawa").setup({
        commentStyle = { italic = true },
        keywordStyle = { italic = false },
        statementStyle = { bold = true },
        transparent = false,
        theme = "dragon", --wave or dragon
        background = { dark = "dragon" },
        overrides = function(colors)
          local theme = colors.theme
          return {
            NormalFloat = { bg = "none" },
            Pmenu = { fg = theme.ui.shade0, bg = "NONE", blend = vim.o.pumblend },
            MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
          }
        end,
      })
    end,
  },

  -- 🌞 Solarized Osaka
  {
    "craftzdog/solarized-osaka.nvim",
    name = "solarized-osaka",
    lazy = current ~= "solarized-osaka",
    priority = current == "solarized-osaka" and 1000 or nil,
    config = function()
      require("solarized-osaka").setup({
        transparent = false,
        styles = {
          comments = { italic = true },
          keywords = { italic = false },
          sidebars = "dark",
          floats = "dark",
        },
        on_highlights = function(hl)
          local prompt = "#2d3149"
          hl.TelescopePromptTitle = { bg = prompt, fg = "#2C94DD" }
        end,
      })
    end,
  },

  -- 💙 Tokyonigh
  {
    "folke/tokyonight.nvim",
    -- Don't rename it to something else
    lazy = current ~= "tokyonight", -- match lowercase!
    priority = current == "tokyonight" and 1000 or nil,
    config = function()
      require("tokyonight").setup({
        style = "night", --storm, night, moon, day
        transparent = false,
        styles = {
          comments = { italic = false },
          keywords = { italic = false },
          sidebars = "transparent",
          floats = "transparent",
        },
      })
    end,
  },
}
