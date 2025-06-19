return {
  "stevearc/conform.nvim",
  enabled = true,
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>mp", -- avoid telescope/lsp conflicts
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      mode = { "n", "v" },
      desc = "Format buffer",
    },
  },
  opts = {
    format_on_save = function(bufnr)
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return -- skip formatting if disabled globally or per buffer
      end
      return {
        timeout_ms = 500,
        lsp_fallback = true,
      }
    end,

    format_after_save = { lsp_fallback = true },
    notify_on_error = true,

    formatters_by_ft = {
      lua = { "stylua" },
      javascript = { "biome", "prettierd", stop_after_first = true },
      typescript = { "biome", "prettierd", stop_after_first = true },
      javascriptreact = { "biome", "prettierd", stop_after_first = true },
      typescriptreact = { "biome", "prettierd", stop_after_first = true },
      json = { "biome", "prettierd", stop_after_first = true },
      html = { "biome", "prettierd", stop_after_first = true },
      css = { "biome", "prettierd", stop_after_first = true },
      scss = { "biome", "prettierd", stop_after_first = true },
      yaml = { "prettierd", "yamllint" },
      markdown = { "prettierd", "markdownlint" },
      sh = { "shfmt" },
      zsh = { "shfmt" },
    },

    formatters = {
      stylua = {
        prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" },
      },
      prettierd = {
        prepend_args = { "--tab-width", "2", "--single-quote", "true", "--trailing-comma", "es5" },
      },
      shfmt = {
        prepend_args = { "-i", "2", "-ci" },
      },
      -- Define custom formatters if needed...
    },
  },
  init = function()
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

    -- User commands for toggling autoformat
    vim.api.nvim_create_user_command("FormatDisable", function(args)
      if args.bang then
        vim.b.disable_autoformat = true
      else
        vim.g.disable_autoformat = true
      end
    end, { desc = "Disable autoformat-on-save", bang = true })

    vim.api.nvim_create_user_command("FormatEnable", function()
      vim.b.disable_autoformat = false
      vim.g.disable_autoformat = false
    end, { desc = "Re-enable autoformat-on-save" })
  end,
}
