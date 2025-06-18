return {
  "stevearc/conform.nvim",
  enabled = true,
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>fm", -- Changed from <leader>f to avoid conflict with future plugins
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      mode = { "n", "v" },
      desc = "Format buffer",
    },
  },
  opts = {
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
    formatters_by_ft = {
      lua = { "stylua" },
      javascript = { "biome" },
      typescript = { "biome" },
      javascriptreact = { "biome" },
      typescriptreact = { "biome" },
      json = { "biome" },
      html = { "biome" },
      css = { "biome" },
      scss = { "biome" },
      yaml = { "prettierd" },
      markdown = { "prettierd" },
    },
    formatters = {
      stylua = {
        prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" },
      },
      prettierd = {
        prepend_args = { "--tab-width", "2" },
      },
      -- Biome can be configured via a biome.json file, no args needed here usually
    },
    --stop_after_first = true --to try formatters sequentially
  },
  init = function()
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
