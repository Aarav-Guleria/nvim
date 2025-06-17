return {
  "ThePrimeagen/git-worktree.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },

  keys = {
    {
      "<leader>wl",
      function()
        require("telescope").extensions.git_worktree.git_worktrees()
      end,
      desc = "List Git Worktrees",
    },
    {
      "<leader>wc",
      function()
        require("telescope").extensions.git_worktree.create_git_worktree()
      end,
      desc = "Create Git Worktree Branch",
    },
  },
  config = function()
    -- The setup needs to happen before the keymaps are used,
    -- but 'config' will run automatically when lazy-loaded.
    local gitworktree = require("git-worktree")
    gitworktree.setup()
    require("telescope").load_extension("git_worktree")
  end,
}
