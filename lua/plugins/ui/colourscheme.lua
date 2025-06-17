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
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        background = { dark = "mocha" },

        transparent_background = true,
        show_end_of_buffer = false,
        term_colors = true,

        integrations = {
          cmp = true,
          gitsigns = true,
          neotree = true,
          dap = true,
          mason = true,
          notify = false,
          flash = true,
          noice = true,
          snacks = true,
          bufferline = true,
          mini = {
            enabled = true,
            indentscope_color = "purple",
          },
          telescope = {
            enabled = true,
            style = "nvchad",
          },

          treesitter = true,
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

  --Rose Pine
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = current ~= "rose-pine",
    priority = current == "rose-pine" and 1000 or nil,

    config = function()
      require("rose-pine").setup({
        variant = "main", -- auto, main, moon, dawn
        dark_variant = "main",
        styles = {
          bold = true,
          italic = false,
          transparency = true,
        },
        highlight_groups = {
          Normal = { bg = "none" },
          Pmenu = { fg = "#e0def4" },
          PmenuSel = { bg = "#4a465d", fg = "#f8f5f2" },
        },
        enable = {
          terminal = true,
          legacy_highlights = false,
          migrations = true,
        },
      })
    end,
  },

  --Gruvbox
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

  --Kanagawa
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
        theme = "wave", --wave or dragon
        background = { dark = "dragon" },
        overrides = function(colors)
          local theme = colors.theme
          return {
            NormalFloat = { bg = "none" },
            Pmenu = { fg = theme.ui.shade0, bg = "NONE", blend = vim.o.pumblend },
            MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },

            TelescopeTitle = { fg = theme.ui.special, bold = true },
            TelescopePromptNormal = { bg = theme.ui.bg_p1 },
            TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
            TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
            TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
            TelescopePreviewNormal = { bg = theme.ui.bg_dim },
            TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
          }
        end,
      })
    end,
  },

  --Solarized Osaka
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

  --Tokyonigh
  {
    "folke/tokyonight.nvim",
    lazy = current ~= "tokyonight",
    priority = current == "tokyonight" and 1000 or nil,

    config = function()
      require("tokyonight").setup({
        style = "night", --storm, night, moon, day
        transparent = true,
        terminal_colors = true,

        styles = {
          comments = { italic = true },
          keywords = { italic = true },
          sidebars = "transparent",
          floats = "transparent",
        },

        dim_inactive = true,
        lualine_bold = true,
      })
    end,
  },
}
