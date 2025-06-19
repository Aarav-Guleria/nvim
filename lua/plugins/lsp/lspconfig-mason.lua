return {
  "neovim/nvim-lspconfig",
  dependencies = {
    {
      "williamboman/mason.nvim",
      config = function()
        require("mason").setup({
          ui = {
            border = "rounded",
            width = 0.8,
            height = 0.8,
            icons = {
              package_installed = "✓",
              package_pending = "➜",
              package_uninstalled = "✗",
            },
          },
          max_concurrent_installers = 10,
        })
      end,
    },
    {
      "williamboman/mason-lspconfig.nvim",
      dependencies = { "williamboman/mason.nvim" },
    },
    {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      dependencies = { "williamboman/mason.nvim" },
      config = function()
        require("mason-tool-installer").setup({
          ensure_installed = {
            "prettierd",
            "stylua",
            "biome",
            "shfmt",
            "shellcheck",
            "markdownlint",
            "node-debug2-adapter",
            "codespell",
          },
          auto_update = true,
          run_on_start = true,
        })
      end,
    },
  },
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lspconfig = require("lspconfig")

    -- Enhanced capabilities with completion and snippet support
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    if cmp_nvim_lsp_ok then
      capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
    end

    -- Enhanced capabilities for better LSP experience
    capabilities.textDocument.completion.completionItem = {
      documentationFormat = { "markdown", "plaintext" },
      snippetSupport = true,
      preselectSupport = true,
      insertReplaceSupport = true,
      labelDetailsSupport = true,
      deprecatedSupport = true,
      commitCharactersSupport = true,
      tagSupport = { valueSet = { 1 } },
      resolveSupport = {
        properties = {
          "documentation",
          "detail",
          "additionalTextEdits",
        },
      },
    }

    local on_attach = function(client, bufnr)
      local opts = { buffer = bufnr, silent = true }
      local keymap = vim.keymap.set

      -- Enhanced LSP keymaps
      keymap("n", "gd", vim.lsp.buf.definition, opts)
      keymap("n", "gD", vim.lsp.buf.declaration, opts)
      keymap("n", "gi", vim.lsp.buf.implementation, opts)
      keymap("n", "go", vim.lsp.buf.type_definition, opts)
      keymap("n", "gr", vim.lsp.buf.references, opts)
      keymap("n", "gs", vim.lsp.buf.signature_help, opts)
      keymap("n", "K", vim.lsp.buf.hover, opts)
      keymap("n", "<leader>rn", vim.lsp.buf.rename, opts)
      keymap("n", "<leader>ca", vim.lsp.buf.code_action, opts)
      keymap("n", "<leader>f", function()
        vim.lsp.buf.format({ async = true })
      end, opts)

      -- Enhanced diagnostic navigation
      keymap("n", "[d", function()
        vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
      end, opts)
      keymap("n", "]d", function()
        vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
      end, opts)
      keymap("n", "[w", function()
        vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARN })
      end, opts)
      keymap("n", "]w", function()
        vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN })
      end, opts)

      -- Workspace commands
      keymap("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
      keymap("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
      keymap("n", "<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, opts)

      -- Enable inlay hints if supported
      if client.supports_method("textDocument/inlayHint") then
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
      end
    end

    -- Setup mason-lspconfig with handlers (v2 approach)
    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        "html",
        "cssls",
        "jsonls",
        "emmet_ls",
        "tailwindcss",
        "bashls",
        "yamlls",
        "marksman",
        "biome",
      },
      automatic_installation = true,
      handlers = {
        -- Default handler for all servers
        function(server_name)
          lspconfig[server_name].setup({
            capabilities = capabilities,
            on_attach = on_attach,
          })
        end,

        -- Specialized server configurations
        ["lua_ls"] = function()
          lspconfig.lua_ls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
              Lua = {
                runtime = {
                  version = "LuaJIT",
                },
                diagnostics = {
                  globals = { "vim", "require" },
                },
                workspace = {
                  checkThirdParty = false,
                  library = {
                    vim.env.VIMRUNTIME,
                    "${3rd}/luv/library",
                  },
                },
                telemetry = { enable = false },
                completion = {
                  callSnippet = "Replace",
                },
              },
            },
          })
        end,

        ["tailwindcss"] = function()
          lspconfig.tailwindcss.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
              tailwindCSS = {
                experimental = {
                  classRegex = {
                    { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
                    { "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
                    { "class:\\s*?[\"'`]([^\"'`]*).*?[\"'`]" },
                    { "className:\\s*?[\"'`]([^\"'`]*).*?[\"'`]" },
                    { "classList:\\s*?[\"'`]([^\"'`]*).*?[\"'`]" },
                  },
                },
              },
            },
          })
        end,

        ["jsonls"] = function()
          lspconfig.jsonls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
              json = {
                schemas = require("schemastore").json.schemas(),
                validate = { enable = true },
              },
            },
          })
        end,
      },
    })

    -- Enhanced diagnostic configuration
    vim.diagnostic.config({
      virtual_text = {
        spacing = 4,
        prefix = "●",
        severity = { min = vim.diagnostic.severity.WARN },
        source = "if_many",
      },
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = "",
          [vim.diagnostic.severity.WARN] = "",
          [vim.diagnostic.severity.HINT] = "󰌵",
          [vim.diagnostic.severity.INFO] = "",
        },
      },
      underline = true,
      update_in_insert = false,
      severity_sort = true,
      float = {
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
    })

    -- Global inlay hints (Neovim 0.10+)
    if vim.fn.has("nvim-0.10") == 1 then
      vim.lsp.inlay_hint.enable(true)
    end
  end,
}
