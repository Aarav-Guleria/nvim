return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify", -- Required for Noice UI
      --"nvim-telescope/telescope.nvim", -- Optional, for :Telescope noice
    },
    config = function()
      local noice = require("noice")
      vim.notify = require("notify") -- Set notify UI for all plugins
      noice.setup({
        cmdline = {
          enabled = true, --cmdline UI
          view = "cmdline_popup", --cmdline, popup, mini
          format = {
            cmdline = { pattern = "", icon = "󱐌 :", lang = "vim" },
            help = { pattern = "^:%s*he?l?p?%s+", icon = "󰮦 :" },
            search_down = { kind = "search", pattern = "^/", icon = "/", lang = "regex" },
            search_up = { kind = "search", pattern = "^%?", icon = "/", lang = "regex" },
            filter = { pattern = "^:%s*!", icon = " $ :", lang = "bash" },
            lua = {
              pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" },
              icon = " :",
              lang = "lua",
            },
            input = { view = "cmdline_input", icon = "󰥻 :" },
          },
        },
        popupmenu = {
          enabled = true,
          backend = "nui",
        },
        views = {
          cmdline_popup = {
            position = {
              row = "95%", -- bottom
              col = "50%", -- center horizontally
            },
            size = {
              width = 60,
              height = "auto",
            },
            border = {
              style = "rounded",
            },
            win_options = {
              winhighlight = {
                Normal = "Normal",
                FloatBorder = "FloatBorder",
              },
            },
          },
          popupmenu = {
            relative = "editor",
            position = { row = "90%", col = "50%" },
            size = { width = 60, height = "auto", max_height = 15 },
            win_options = {
              winhighlight = {
                Normal = "Normal",
                FloatBorder = "DiagnosticInfo",
              },
            },
          },
          mini = {
            position = { row = -2, col = "100%" },
            size = { width = "auto", height = "auto", max_height = 15 },
          },
        },
        lsp = {
          progress = { enabled = true },
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
          signature = {
            auto_open = { enabled = false },
          },
        },
        signature = {
          enabled = true,
        },
        messages = {
          enabled = false,
        },
        routes = {
          {
            filter = {
              event = "msg_show",
              any = {
                { find = "%d+L, %d+B" },
                { find = "; after #%d+" },
                { find = "; before #%d+" },
                { find = "%d fewer lines" },
                { find = "%d more lines" },
              },
            },
            opts = { skip = true },
          },
        },
        health = {
          checker = true,
        },
        presets = {
          bottom_search = false, -- use a classic bottom cmdline for search
          command_palette = false, -- position the cmdline and popupmenu together
          long_message_to_split = false, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = true, -- borders around hover/signature
        },
      })
    end,
  },
}
