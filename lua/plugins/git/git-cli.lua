return {
  "tpope/vim-fugitive",
  cmd = { "Git" },
  config = function()
    vim.keymap.set("n", "<leader>gg", function()
      vim.cmd("Git")
    end, { desc = "Open Git status" })

    local augroup = vim.api.nvim_create_augroup("myFugitive", {})
    vim.api.nvim_create_autocmd("BufWinEnter", {
      group = augroup,
      pattern = "*",
      callback = function()
        if vim.bo.ft ~= "fugitive" then
          return
        end
        local bufnr = vim.api.nvim_get_current_buf()
        local opts = { buffer = bufnr, remap = false }

        vim.keymap.set("n", "<leader>P", function()
          vim.cmd("Git push --quiet")
        end, opts)
        vim.keymap.set("n", "<leader>p", function()
          vim.cmd("Git pull --rebase --quiet")
        end, opts)
        vim.keymap.set("n", "<leader>t", ":Git push -u origin ", opts)
      end,
    })
  end,
}
