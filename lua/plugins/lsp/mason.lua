return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  build = ":MasonUpdate",
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local mason_tool_installer = require("mason-tool-installer")
    -- 🧱 Basic UI and installation paths for mason
    mason.setup({
      ui = {
        border = "rounded",
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })
    -- 🧠 Ensure language servers are installed
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
      automatic_installation = true,
    })
    -- 🔧 Ensure formatters/linters/debuggers are installed
    mason_tool_installer.setup({
      ensure_installed = {
        -- Removed prettierd from JS/TS since biome handles that
        -- Keep if you want for yaml/markdown or remove entirely
        "prettierd",
        -- "eslint_d", -- commented out since you use biome and eslint.nvim is optional
        "stylua",
        "biome",
      },
      auto_update = true,
      run_on_start = true,
      start_delay = 3000, -- delay in ms before starting
      debounce_hours = 24, -- minimum hours between two updates
    })
  end,
}
