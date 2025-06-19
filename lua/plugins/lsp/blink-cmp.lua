return {
  "saghen/blink.cmp",
  enabled = true,
  lazy = false, -- make sure we load this during startup if it is your main completion plugin
  -- use a release tag to download pre-built binaries
  version = "v0.*",
  -- OR build from source, requires nightly: build = 'cargo build --release',
  dependencies = {
    "rafamadriz/friendly-snippets",
    -- add this if you use luasnip
    "L3MON4D3/LuaSnip",
  },

  opts = {
    -- 'default' for mappings similar to built-in completion
    -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
    -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
    keymap = { preset = "default" },

    appearance = {
      -- Sets the fallback highlight groups to nvim-cmp's highlight groups
      -- Useful for when your theme doesn't support blink.cmp
      -- will be removed in a future release
      use_nvim_cmp_as_default = true,
      -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing and ensures icons are aligned
      nerd_font_variant = "mono",
    },

    -- experimental signature help support
    signature = { enabled = true },

    completion = {
      accept = {
        -- experimental auto-brackets support
        auto_brackets = {
          enabled = false, -- disabled since using nvim-ts-autotag
        },
      },

      menu = {
        auto_show = true,
        draw = {
          treesitter = { "lsp" }, -- Enable treesitter highlighting for LSP items
          columns = {
            { "kind_icon" },
            { "label", "label_description", gap = 1 },
            { "kind" },
            { "source_name" },
          },
          components = {
            kind_icon = {
              ellipsis = false,
              text = function(ctx)
                local kind_icons = {
                  Text = "󰉿",
                  Method = "󰆧",
                  Function = "󰊕",
                  Constructor = "",
                  Field = "󰜢",
                  Variable = "󰀫",
                  Class = "󰠱",
                  Interface = "",
                  Module = "",
                  Property = "󰜢",
                  Unit = "󰑭",
                  Value = "󰎠",
                  Enum = "",
                  Keyword = "󰌋",
                  Snippet = "",
                  Color = "󰏘",
                  File = "󰈙",
                  Reference = "󰈇",
                  Folder = "󰉋",
                  EnumMember = "",
                  Constant = "󰏿",
                  Struct = "",
                  Event = "",
                  Operator = "󰆕",
                  TypeParameter = "󰊄",
                }
                return (kind_icons[ctx.kind] or ctx.kind) .. " "
              end,
              highlight = "BlinkCmpKind",
            },
            kind = {
              ellipsis = false,
              width = { fill = true },
              text = function(ctx)
                return ctx.kind
              end,
              highlight = "BlinkCmpKind",
            },
            source_name = {
              width = { max = 30 },
              text = function(ctx)
                local source_names = {
                  lsp = "[LSP]",
                  path = "[Path]",
                  snippets = "[Snip]",
                  buffer = "[Buf]",
                }
                return source_names[ctx.source_name] or ("[" .. ctx.source_name .. "]")
              end,
              highlight = "BlinkCmpSource",
            },
          },
        },
      },

      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
        treesitter_highlighting = true,
        window = {
          border = "rounded",
          scrollbar = true,
          direction_priority = {
            menu_north = { "e", "w", "n", "s" },
            menu_south = { "e", "w", "s", "n" },
          },
        },
      },

      ghost_text = {
        enabled = false, -- disabled since using copilot
      },
    },

    -- FIXED: Updated snippets configuration for LuaSnip integration
    snippets = {
      preset = "luasnip", -- This is the key change - use luasnip preset
    },

    sources = {
      -- FIXED: Updated source configuration - use 'snippets' instead of 'luasnip'
      default = { "lsp", "path", "snippets", "buffer" },
      -- per-filetype override example
      -- lua = { "lsp", "snippets", "buffer" },

      providers = {
        lsp = {
          name = "LSP",
          module = "blink.cmp.sources.lsp",
          enabled = true,
          score_offset = 90,
          -- LSP provider options (no show_signature option available)
          opts = {},
        },
        path = {
          name = "Path",
          module = "blink.cmp.sources.path",
          score_offset = 3,
          opts = {
            trailing_slash = false,
            label_trailing_slash = true,
            get_cwd = function(context)
              return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
            end,
            show_hidden_files_by_default = false,
          },
        },
        -- REMOVED: luasnip provider (now handled by snippets preset)
        buffer = {
          name = "Buffer",
          module = "blink.cmp.sources.buffer",
          enabled = true,
          score_offset = 5,
          opts = {
            -- default to all visible buffers
            get_bufnrs = function()
              return vim
                .iter(vim.api.nvim_list_wins())
                :map(function(win)
                  return vim.api.nvim_win_get_buf(win)
                end)
                :filter(function(buf)
                  return vim.bo[buf].buftype ~= "nofile"
                end)
                :totable()
            end,
          },
        },
      },
    },
  },

  -- allows extending the providers array elsewhere in config
  opts_extend = { "sources.default" },
}
