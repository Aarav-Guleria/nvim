return {
  "monkoose/neocodeium",
  enabled = false,
  event = "InsertEnter",
  signs = false,
  config = function()
    require("neocodeium").setup({})

    -- Keymaps for ghost text interaction
    vim.keymap.set("i", "<A-f>", require("neocodeium").accept, { silent = true })
    vim.keymap.set("i", "<A-w>", require("neocodeium").accept_word, { silent = true })
    vim.keymap.set("i", "<A-a>", require("neocodeium").accept_line, { silent = true })
    vim.keymap.set("i", "<A-e>", require("neocodeium").cycle_or_complete, { silent = true })
    vim.keymap.set("i", "<A-r>", function()
      require("neocodeium").cycle_or_complete(-1)
    end, { silent = true })
    vim.keymap.set("i", "<A-c>", require("neocodeium").clear, { silent = true })
  end,
}
