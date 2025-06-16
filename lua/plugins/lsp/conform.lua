return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>f",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      mode = { "n", "v" },
      desc = "Format buffer",
    },
  },
  opts = function()
    local biome_filetypes = {
      "javascript",
      "typescript",
      "javascriptreact",
      "typescriptreact",
      "json",
      "html",
      "css",
      "scss",
    }
    local formatters_by_ft = {
      lua = { "stylua" },
      yaml = { "prettierd" }, -- kept prettierd only here
      markdown = { "prettierd" }, -- and here
    }
    for _, ft in ipairs(biome_filetypes) do
      formatters_by_ft[ft] = { "biome" }
    end
    return {
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
      formatters_by_ft = formatters_by_ft,
      formatters = {
        stylua = {
          prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" },
        },
        prettierd = {
          prepend_args = { "--tab-width", "2" },
        },
        -- No prettierd for JS/TS here
      },
    }
  end,
  init = function()
    -- Avoid deprecated globals by assigning once at init
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
