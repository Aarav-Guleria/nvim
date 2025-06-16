return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("bufferline").setup({
      options = {
        mode = "buffers",
        diagnostics = "nvim_lsp",
        separator_style = "slant",
        always_show_bufferline = false,
        show_buffer_close_icons = true,
        show_close_icon = false,
        offsets = {
          {
            filetype = "neo-tree",
            text = "File Explorer",
            highlight = "Directory",
            text_align = "left",
          },
        },
      },
    })
    vim.keymap.set("n", "<TAB>", ":BufferLineCycleNext<CR>", { desc = "Next buffer" })
    vim.keymap.set("n", "<S-TAB>", ":BufferLineCyclePrev<CR>", { desc = "Prev buffer" })
  end,
  enabled = true,
}

