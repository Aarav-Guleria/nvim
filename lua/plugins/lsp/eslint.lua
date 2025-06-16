return {
  "MunifTanjim/eslint.nvim",
  ft = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "vue",
    "svelte",
  },
  dependencies = {
    "neovim/nvim-lspconfig",
  },
  config = function()
    local eslint = require("eslint")
    eslint.setup({
      bin = "eslint_d",
      code_actions = {
        enable = false,
        apply_on_save = { enable = false },
      },
      diagnostics = {
        enable = true,
        run_on = "type",
      },
    })
    -- Filter out "no-unused-vars" warnings
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client or client.name ~= "eslint" then
          return
        end
        local ns = vim.api.nvim_create_namespace("eslint_filtered")
        local function filter_and_show(_, bufnr, diagnostics, opts)
          local filtered = vim.tbl_filter(function(d)
            return not d.message:match("no%-unused%-vars")
          end, diagnostics)
          vim.diagnostic.show(ns, bufnr, filtered, opts)
        end
        vim.diagnostic.handlers["eslint_virtual_text"] = {
          show = filter_and_show,
          hide = function(_, bufnr)
            vim.diagnostic.hide(ns, bufnr)
          end,
        }
        vim.diagnostic.config({
          virtual_text = {
            source = "if_many",
            severity = nil,
            format = function(d)
              return d.source == "eslint" and d.message or nil
            end,
            handler = vim.diagnostic.handlers["eslint_virtual_text"],
          },
        }, args.buf)
      end,
    })
    -- Add keymap to restart ESLint
    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "vue",
        "svelte",
      },
      callback = function()
        vim.keymap.set("n", "<leader>lre", "<cmd>EslintRestart<CR>", { noremap = true, silent = true, buffer = true })
      end,
    })
  end,
}
