return {
  "saghen/blink.cmp",
  lazy = false, -- lazy loading handled internally
  -- optional: provides snippets for the snippet source
  dependencies = "rafamadriz/friendly-snippets",

  -- use a release tag to download pre-built binaries
  version = "v0.*",
  -- OR build from source, requires nightly
  -- build = 'cargo build --release',

  opts = {
    -- 'default' for mappings similar to built-in completion
    -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
    -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
    -- see the "default configuration" section below for full documentation on how to define
    -- your own keymap.
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
          enabled = false,
        },
      },
      menu = {
        -- Don't automatically show completions
        auto_show = false,
        draw = {
          columns = {
            { "kind_icon" },
            { "label", "label_description", gap = 1 },
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
            source_name = {
              width = { fill = true },
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
        },
      },
      ghost_text = {
        enabled = false,
      },
    },

    --interraction with luasnip
    snippets = {
      expand = function(snippet)
        require("luasnip").lsp_expand(snippet)
      end,
      active = function(filter)
        if filter and filter.direction then
          return require("luasnip").jumpable(filter.direction)
        end
        return require("luasnip").in_snippet()
      end,
      jump = function(direction)
        require("luasnip").jump(direction)
      end,
    },

    sources = {
      -- default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, via `opts_extend`
      default = { "lsp", "path", "snippets", "buffer" },
      -- optionally disable cmdline completions
      -- cmdline = {},

      -- adding any nvim-cmp sources here will enable them
      -- with blink.cmp (assuming the dependencies are installed)
      providers = {
        lsp = {
          name = "LSP",
          module = "blink.cmp.sources.lsp",
          enabled = true,
          score_offset = 90, -- the higher the number, the higher the priority
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
        snippets = {
          name = "Snippets",
          module = "blink.cmp.sources.snippets",
          score_offset = 85,
          opts = {
            friendly_snippets = true,
            search_paths = { vim.fn.stdpath("config") .. "/snippets" },
            global_snippets = { "all" },
            extended_filetypes = {},
            ignored_filetypes = {},
          },
        },
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
  -- allows extending the providers array elsewhere in config without having to redefine it
  opts_extend = { "sources.default" },
}
