return {
  --Terminal toggling for tmux sessions inside nvim, enabled separately
  -- {
  --   "akinsho/toggleterm.nvim",
  --   config = function()
  --     require("toggleterm").setup({
  --       size = 20,
  --       open_mapping = [[<c-\>]],
  --       direction = "horizontal",
  --       shade_terminals = true,
  --     })
  --   end,
  -- },

  --pane navigation and resizing from nvim
  {
    "aserowy/tmux.nvim",
    config = function()
      require("tmux").setup({
        -- Default config, customize as needed
        copy_sync = {
          enable = true,
        navigation = { enable = true, cycle_navigation = true },
        },
      })
    end,
  },

  --pane navigatons
  {
    "christoomey/vim-tmux-navigator",
    lazy = false, -- load immediately for keymaps to work
  },

  {
    "nvim-zh/colorful-winsep.nvim",
    config = function()
      require("colorful-winsep").setup()
    end,
  },
}
