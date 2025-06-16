vim.g.skip_ts_context_commentstring_module = true
return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "JoosepAlviste/nvim-ts-context-commentstring",
      "nvim-treesitter/playground",
      "HiPhish/rainbow-delimiters.nvim",
    },
    config = function()
      local languages = {
        "lua",
        "vim",
        "vimdoc",
        "bash",
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "json",
        "http",
      }
      require("nvim-treesitter.configs").setup({
        ensure_installed = languages,
        auto_install = true,
        highlight = { enable = true },
        indent = {
          enable = true,
          disable = { "lua" },
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            node_decremental = "grm",
            scope_incremental = "grc",
          },
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
              ["aa"] = "@parameter.outer",
              ["ia"] = "@parameter.inner",
              ["ab"] = "@block.outer",
              ["ib"] = "@block.inner",
              ["al"] = "@loop.outer",
              ["il"] = "@loop.inner",
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["]m"] = "@function.outer",
              ["]]"] = "@class.outer",
            },
            goto_next_end = {
              ["]M"] = "@function.outer",
              ["]["] = "@class.outer",
            },
            goto_previous_start = {
              ["[m"] = "@function.outer",
              ["[["] = "@class.outer",
            },
            goto_previous_end = {
              ["[M"] = "@function.outer",
              ["[]"] = "@class.outer",
            },
          },
        },
        matchup = {
          enable = true, -- only if plugin is installed
        },
        rainbow_delimiters = {
          enable = true,
        },
      })
      -- Safe folds setup for ufo.nvim
      --vim.opt.foldmethod = "manual"
      --vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      vim.opt.foldenable = true
      vim.opt.foldlevel = 99
      vim.opt.foldlevelstart = 99
      vim.opt.foldnestmax = 3
      vim.opt.foldcolumn = "0"
    end,
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    lazy = true,
    config = function()
      require("ts_context_commentstring").setup({
        enable_autocmd = false, -- hooks handle it
      })
    end,
  },
}
