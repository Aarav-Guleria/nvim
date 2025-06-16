return {
  -- PLUGIN: plenary (utility lib for many plugins)
  {
    "nvim-lua/plenary.nvim",
    lazy = true,
  },
  -- TypeScript tools (replaces ts_ls)
  {
    "pmizio/typescript-tools.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "neovim/nvim-lspconfig",
    },
    ft = {
      "typescript",
      "typescriptreact",
      "javascript",
      "javascriptreact",
    },
    opts = {
      settings = {
        tsserver_file_preferences = {
          includeInlayParameterNameHints = "all",
          includeCompletionsForModuleExports = true,
          includeInlayFunctionLikeReturnTypeHints = true,
        },
      },
    },
  },
  -- Tailwind and general auto-tag support
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    ft = {
      "html",
      "xml",
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "svelte",
      "vue",
      "tsx",
      "jsx",
    },
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  -- CSS/HTML Color Highlighter
  {
    "norcalli/nvim-colorizer.lua",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("colorizer").setup({ "*" }, {
        RGB = true,
        RRGGBB = true,
        names = true,
        RRGGBBAA = true,
        rgb_fn = true,
        hsl_fn = true,
        css = true,
      })
    end,
  },
  -- LuaSnip - snippet engine
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    event = "InsertEnter",
    --dependencies = { "rafamadriz/friendly-snippets" }, --in blink cmp
    config = function()
      local luasnip = require("luasnip")
      luasnip.config.set_config({
        history = true,
        updateevents = "TextChanged,TextChangedI",
        enable_autosnippets = true,
      })
      require("luasnip.loaders.from_vscode").lazy_load()
      vim.keymap.set({ "i", "s" }, "<C-k>", function()
        if luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        end
      end, { silent = true })
      vim.keymap.set({ "i", "s" }, "<C-j>", function()
        if luasnip.jumpable(-1) then
          luasnip.jump(-1)
        end
      end, { silent = true })
    end,
  },
  -- REST client plugin with rocks disabled to fix luarocks build error
  {
    "rest-nvim/rest.nvim",
    ft = "http",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      rocks = {
        enabled = false,
        hererocks = false,
      },
    },
    config = function()
      require("rest-nvim").setup({
        result_split_horizontal = false,
        result_split_in_place = false,
        skip_ssl_verification = false,
        encode_url = true,
        highlight = {
          enabled = true,
          timeout = 150,
        },
        result = {
          show_url = true,
          show_curl_command = false,
          show_http_info = true,
          show_headers = true,
          formatters = {
            json = "jq",
            html = function(body)
              return vim.fn.system({ "tidy", "-i", "-q", "-" }, body)
            end,
          },
        },
        jump_to_request = false,
        env_file = ".env",
        custom_dynamic_variables = {},
        yank_dry_run = true,
      })
      vim.keymap.set("n", "<localleader>rr", "<Plug>RestNvim", { desc = "Run REST request" })
      vim.keymap.set("n", "<localleader>rp", "<Plug>RestNvimPreview", { desc = "Preview REST request" })
      vim.keymap.set("n", "<localleader>rl", "<Plug>RestNvimLast", { desc = "Re-run last REST request" })
    end,
  },
}
