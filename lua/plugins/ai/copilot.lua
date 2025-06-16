return {
  "github/copilot.vim",
  event = "InsertEnter",
  config = function()
    -- Disable default tab mapping
    vim.g.copilot_no_tab_map = true

    --using Alm+M instead of tab to avoid any conflicts
    vim.api.nvim_set_keymap("i", "<M-l>", 'copilot#Accept("<CR>")', {
      expr = true,
      silent = true,
      noremap = true,
    })

    --text for ghost text (experimental)
    vim.g.copilot_assume_mapped = true
    vim.g.copilot_tab_fallback = ""
    vim.g.copilot_enable = 1

    --filetype filtering
    vim.g.copilot_filetypes = {
      ["TelescopePrompt"] = false,
      ["markdown"] = true,
      [""] = false,
    }
  end,
}
