return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lspconfig = require("lspconfig")
    -- Check if cmp_nvim_lsp is available for capabilities
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    if cmp_nvim_lsp_ok then
      capabilities = cmp_nvim_lsp.default_capabilities()
    end
    local on_attach = function(_, bufnr)
      local opts = { buffer = bufnr }
      local keymap = vim.keymap.set
      keymap("n", "gd", vim.lsp.buf.definition, opts)
      keymap("n", "K", vim.lsp.buf.hover, opts)
      keymap("n", "<leader>rn", vim.lsp.buf.rename, opts)
      keymap("n", "<leader>ca", vim.lsp.buf.code_action, opts)
      keymap("n", "[d", function()
        vim.diagnostic.goto_prev()
      end, opts)
      keymap("n", "]d", function()
        vim.diagnostic.goto_next()
      end, opts)
    end
    local mason_lspconfig = require("mason-lspconfig")
    mason_lspconfig.setup({
      ensure_installed = {
        "lua_ls",
        "html",
        "cssls",
        "jsonls",
        "emmet_ls",
        "eslint",
        "tailwindcss",
      },
    })
    -- Use simple loop instead of setup_handlers
    for _, server in ipairs(mason_lspconfig.get_installed_servers()) do
      local opts = {
        capabilities = capabilities,
        on_attach = on_attach,
      }
      if server == "lua_ls" then
        opts.settings = {
          Lua = {
            diagnostics = {
              globals = { "vim", "require" },
            },
            workspace = {
              checkThirdParty = false,
              library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = { enable = false },
          },
        }
      elseif server == "tailwindcss" then
        opts.settings = {
          tailwindCSS = {
            experimental = {
              classRegex = {
                { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
                { "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
                { "class:\\s*?[\"'`]([^\"'`]*).*?[\"'`]" },
                { "className:\\s*?[\"'`]([^\"'`]*).*?[\"'`]" },
              },
            },
          },
        }
      end
      lspconfig[server].setup(opts)
    end
    -- Diagnostic signs
    local signs = {
      Error = "",
      Warn = "",
      Hint = "󰌵",
      Info = "",
    }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end
  end,
}
