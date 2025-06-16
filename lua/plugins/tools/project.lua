return {
  {
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-telescope/telescope.nvim", -- Ensure telescope is loaded before project.nvim
    },
    config = function()
      require("project_nvim").setup({
        detection_methods = { "lsp", "pattern" },
        patterns = {
          ".git",
          "Makefile",
          "package.json",
          "pyproject.toml",
          "go.mod",
        },
      })

      -- Load the Telescope extension for projects
      require("telescope").load_extension("projects")
    end,
  },
}
