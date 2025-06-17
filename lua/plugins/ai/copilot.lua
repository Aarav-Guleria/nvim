return {
  "github/copilot.vim",
  event = "InsertEnter",
  config = function()
    -- Disable default <Tab> mapping
    vim.g.copilot_no_tab_map = true

    --Alt‑l to accept suggestio instead
    vim.api.nvim_set_keymap("i", "<M-l>", 'copilot#Accept("<CR>")', {
      expr = true,
      silent = true,
      noremap = true,
    })

    --map dismiss
    vim.api.nvim_set_keymap("i", "<M-,>", "copilot#Dismiss()", { expr = true, silent = true, noremap = true })

    -- Limit filetypes
    vim.g.copilot_filetypes = {
      ["TelescopePrompt"] = false,
      markdown = true,
      [""] = false,
      -- add more here, python = true, lua = true, etc.
    }

    vim.api.nvim_set_hl(0, "CopilotVirtualText", { fg = "#555555", italic = true })

    -- Enable globally
    vim.g.copilot_enable = 1
    vim.g.copilot_assume_mapped = true
    vim.g.copilot_tab_fallback = ""
  end,
}
