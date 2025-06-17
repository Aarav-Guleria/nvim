return {
  "karb94/neoscroll.nvim",
  event = "VeryLazy",
  opts = {
    --Custom mappings can go here (or leave it empty to use default scroll keys)
    --mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
    hide_cursor = true,
    stop_eof = true,
    use_local_scrolloff = false,
    respect_scrolloff = false,
    cursor_scrolls_alone = true,
    easing_function = "sine", -- Options: "quadratic", "cubic", "quartic", "quintic", "circular", "sine"
  },
}
