return {
  {
    "nvim-lua/plenary.nvim",
    lazy = true,
  },

  -- TypeScript tools (modern replacement for ts_ls)
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
      on_attach = function(client, bufnr)
        -- Disable formatting if you're using biome/prettier
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false

        -- Enable inlay hints
        if client.supports_method("textDocument/inlayHint") then
          vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        end
      end,
      settings = {
        separate_diagnostic_server = true,
        publish_diagnostic_on = "insert_leave",
        expose_as_code_action = {},
        tsserver_path = nil,
        tsserver_plugins = {
          -- Add biome plugin if you have it
          -- "@biomejs/biome-lsp",
        },
        tsserver_max_memory = "auto",
        tsserver_format_options = {},
        tsserver_file_preferences = {
          includeInlayParameterNameHints = "all",
          includeCompletionsForModuleExports = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
        tsserver_locale = "en",
        complete_function_calls = false,
        include_completions_with_insert_text = true,
        code_lens = "off",
        disable_member_code_lens = true,
        jsx_close_tag = {
          enable = false,
          filetypes = { "javascriptreact", "typescriptreact" },
        },
      },
    },
    config = function(_, opts)
      require("typescript-tools").setup(opts)

      -- Enhanced inlay hint styling
      vim.api.nvim_set_hl(0, "LspInlayHint", {
        fg = "#6c7086",
        italic = true,
        bg = "NONE",
      })

      -- Add TypeScript specific keymaps
      vim.keymap.set("n", "<leader>to", "<cmd>TSToolsOrganizeImports<cr>", { desc = "Organize Imports" })
      vim.keymap.set("n", "<leader>ts", "<cmd>TSToolsSortImports<cr>", { desc = "Sort Imports" })
      vim.keymap.set("n", "<leader>tu", "<cmd>TSToolsRemoveUnused<cr>", { desc = "Remove Unused" })
      vim.keymap.set("n", "<leader>td", "<cmd>TSToolsGoToSourceDefinition<cr>", { desc = "Go to Source Definition" })
      vim.keymap.set("n", "<leader>tf", "<cmd>TSToolsFixAll<cr>", { desc = "Fix All" })
    end,
  },

  -- Enhanced autotag with better configuration
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
      "rescript",
      "php",
      "glimmer",
      "handlebars",
      "hbs",
      "astro",
    },
    config = function()
      require("nvim-ts-autotag").setup({
        opts = {
          enable_close = true,
          enable_rename = true,
          enable_close_on_slash = false,
        },
        per_filetype = {
          ["html"] = {
            enable_close = false,
          },
        },
      })

      -- Disable mini.pairs for these filetypes to avoid conflicts
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
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
          "astro",
        },
        callback = function()
          vim.b.minipairs_disable = true
        end,
        desc = "Disable mini.pairs for web filetypes",
      })
    end,
  },

  -- Enhanced colorizer with better performance
  {
    "norcalli/nvim-colorizer.lua",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("colorizer").setup({
        filetypes = { "*" },
        user_default_options = {
          RGB = true,
          RRGGBB = true,
          names = true,
          RRGGBBAA = true,
          AARRGGBB = true,
          rgb_fn = true,
          hsl_fn = true,
          css = true,
          css_fn = true,
          mode = "background",
          tailwind = true,
          sass = { enable = true, parsers = { "css" } },
          virtualtext = "■",
          always_update = false,
        },
      })

      -- Add commands for colorizer control
      vim.keymap.set("n", "<leader>ct", "<cmd>ColorizerToggle<cr>", { desc = "Toggle Colorizer" })
      vim.keymap.set("n", "<leader>cr", "<cmd>ColorizerReloadAllBuffers<cr>", { desc = "Reload Colorizer" })
    end,
  },

  -- Updated REST client (rest.nvim successor)
  {
    "rest-nvim/rest.nvim",
    ft = "http",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("rest-nvim").setup({
        -- Client configuration
        client = "curl",
        env_file = ".env",
        env_pattern = "\\.env$",
        env_edit_command = "tabedit",
        encode_url = true,
        skip_ssl_verification = false,
        custom_dynamic_variables = {},
        logs = {
          level = "info",
          save = true,
        },
        -- Result configuration
        result = {
          split_horizontal = false,
          split_in_place = false,
          split_stay_in_current_window_after_split = true,
          behavior = {
            decode_url = true,
            show_info = {
              url = true,
              headers = true,
              http_info = true,
              curl_command = false,
            },
            statistics = {
              enable = true,
              ---@see https://curl.se/libcurl/c/curl_easy_getinfo.html
              stats = {
                { "total_time", title = "Time taken:" },
                { "size_download_t", title = "Download size:" },
              },
            },
            formatters = {
              json = "jq",
              html = function(body)
                if vim.fn.executable("tidy") == 1 then
                  return vim.fn.system({ "tidy", "-i", "-q", "--show-errors", "0" }, body)
                end
                return body
              end,
            },
          },
        },
        -- Highlight configuration
        highlight = {
          enable = true,
          timeout = 750,
        },
        -- Jump to request configuration
        jump_to_request = false,
        yank_dry_run = true,
        search_back = true,
      })

      -- Enhanced keymaps
      vim.keymap.set("n", "<localleader>rr", "<cmd>Rest run<cr>", { desc = "Run REST request" })
      vim.keymap.set("n", "<localleader>rl", "<cmd>Rest run last<cr>", { desc = "Re-run last REST request" })
      vim.keymap.set("n", "<localleader>rp", "<cmd>Rest run<cr>", { desc = "Preview REST request" })
      vim.keymap.set("n", "<localleader>re", "<cmd>Rest env show<cr>", { desc = "Show environment variables" })
      vim.keymap.set("n", "<localleader>rs", "<cmd>Rest env select<cr>", { desc = "Select environment" })
    end,
  },

  -- Additional recommended plugins for web development
  {
    "b0o/schemastore.nvim",
    lazy = true,
    ft = { "json", "jsonc", "yaml" },
  },

  -- Enhanced HTML/CSS support
  {
    "mattn/emmet-vim",
    ft = {
      "html",
      "css",
      "scss",
      "sass",
      "less",
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "vue",
      "svelte",
      "astro",
    },
    config = function()
      vim.g.user_emmet_mode = "a"
      vim.g.user_emmet_leader_key = "<C-z>"
      vim.g.user_emmet_settings = {
        javascript = {
          extends = "jsx",
        },
        typescript = {
          extends = "tsx",
        },
      }
    end,
  },

  -- Package.json management
  {
    "vuki656/package-info.nvim",
    dependencies = "MunifTanjim/nui.nvim",
    ft = "json",
    config = function()
      require("package-info").setup({
        colors = {
          up_to_date = "#3C4048",
          outdated = "#d19a66",
        },
        icons = {
          enable = true,
          style = {
            up_to_date = "|  ",
            outdated = "|  ",
          },
        },
        autostart = true,
        hide_up_to_date = false,
        hide_unstable_versions = false,
        package_manager = "npm",
      })

      -- Keymaps for package info
      vim.keymap.set("n", "<leader>ns", require("package-info").show, { desc = "Show package versions" })
      vim.keymap.set("n", "<leader>nc", require("package-info").hide, { desc = "Hide package versions" })
      vim.keymap.set("n", "<leader>nt", require("package-info").toggle, { desc = "Toggle package versions" })
      vim.keymap.set("n", "<leader>nu", require("package-info").update, { desc = "Update package" })
      vim.keymap.set("n", "<leader>nd", require("package-info").delete, { desc = "Delete package" })
      vim.keymap.set("n", "<leader>ni", require("package-info").install, { desc = "Install package" })
      vim.keymap.set("n", "<leader>np", require("package-info").change_version, { desc = "Change package version" })
    end,
  },
}
