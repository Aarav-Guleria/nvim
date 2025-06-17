return {
  "sphamba/smear-cursor.nvim",
  opts = {
    stiffness = 0.8,
    trailing_stiffness = 0.5,
    distance_stop_animating = 0.5,
    smear_insert_mode = false,
    smear_cmdline_normal_mode = false,
    smear_cmdline_insert_mode = false,
  },
  config = function(_, opts)
    require("smear").setup(opts)

    --Disable smearcursor on Snacks cmdline open
    vim.api.nvim_create_autocmd("User", {
      pattern = "SnacksCmdlineEnter",
      callback = function()
        vim.g.smear_cursor_enabled = false
      end,
    })

    --Reenable smearcursor when Snacks cmdline closes
    vim.api.nvim_create_autocmd("User", {
      pattern = "SnacksCmdlineLeave",
      callback = function()
        vim.g.smear_cursor_enabled = true
      end,
    })
  end,
}
