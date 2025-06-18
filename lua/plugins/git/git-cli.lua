return {
  "tpope/vim-fugitive",
  cmd = { "Git" },
  config = function()
    local map = vim.keymap.set
    map("n", "<leader>gg", ":Git<CR>", { desc = "Open Git status" })
    map("n", "<leader>gc", ":Git commit<CR>", { desc = "Git commit" })
    map("n", "<leader>gb", ":Git branch<CR>", { desc = "Git branch" })

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
        map("n", "<leader>P", ":Git push --quiet<CR>", opts)
        map("n", "<leader>p", ":Git pull --rebase --quiet<CR>", opts)
        map("n", "<leader>t", ":Git push -u origin ", opts)
      end,
    })
  end,
}
