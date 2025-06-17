return {
  "github/copilot.vim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    vim.g.copilot_no_tab_map = true
    vim.g.copilot_assume_mapped = true
    vim.g.copilot_tab_fallback = ""
    vim.g.copilot_enable = 1
    vim.g.copilot_filetypes = {
      TelescopePrompt = false,
      ["*"] = true,
    }
    --alt M to accept ghost suggestion and alt , to remove ghost suggeston
    vim.api.nvim_set_keymap("i", "<M-l>", 'copilot#Accept("<CR>")', { expr = true, silent = true, noremap = true })
    vim.api.nvim_set_keymap("i", "<M-,>", "copilot#Dismiss()", { expr = true, silent = true, noremap = true })

    vim.api.nvim_set_hl(0, "CopilotVirtualText", { fg = "#888888", italic = true })
  end,
}
