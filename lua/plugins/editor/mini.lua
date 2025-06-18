-- In plugins/editor/mini.lua

return {
  "echasnovski/mini.nvim",
  version = false,
  event = "VeryLazy",

  dependencies = {
    {
      "lukas-reineke/indent-blankline.nvim",
      main = "ibl",
      opts = {
        indent = { char = "│" },
        scope = {
          enabled = false, -- disable scope highlight to avoid conflict with mini.indentscope
        },
        exclude = {
          filetypes = { "help", "dashboard", "neo-tree", "lazy", "mason" },
        },
      },
    },
  },

  config = function()
    vim.g.miniindentscope_disable = false
    vim.g.ministatusline_disable = true
    vim.g.ministatuscolumn_disable = true

    --Core Editing Enhancements
    --require("mini.ai").setup() if conflicting with treesitter textobjects
    require("mini.comment").setup()
    require("mini.diff").setup()
    require("mini.operators").setup()
    require("mini.splitjoin").setup()
    require("mini.trailspace").setup()
    require("mini.surround").setup()
    require("mini.pairs").setup()
    --Structural/Visual Enhancements
    require("mini.align").setup()
    require("mini.move").setup() -- mini.move setup

    --Keymaps for mini.move
    local keymap = vim.keymap.set
    keymap("n", "<A-j>", function()
      require("mini.move").move_line("down")
    end, { desc = "Move line down" })
    keymap("n", "<A-k>", function()
      require("mini.move").move_line("up")
    end, { desc = "Move line up" })
    keymap("v", "<A-j>", function()
      require("mini.move").move_selection("down")
    end, { desc = "Move selection down" })
    keymap("v", "<A-k>", function()
      require("mini.move").move_selection("up")
    end, { desc = "Move selection up" })

    require("mini.bracketed").setup()

    --Animate UI (except for popups like Noice)
    require("mini.animate").setup({
      open = { enable = false },
      close = { enable = false },
      resize = { enable = false },
      cursor = { enable = false },
      scroll = { enable = false },
      windows = {
        exclude = {
          filetypes = { "notify", "noice", "lazy", "mason" },
          buftypes = { "nofile", "prompt", "popup" },
        },
      },
    })

    --indent guides with active scope highlight only
    require("mini.indentscope").setup({
      symbol = "│",
      options = { try_as_border = true },
      draw = {
        delay = 0,
        animation = require("mini.indentscope").gen_animation.none(),
      },
    })

    -- Disable indentscope, and mini move in popup plugins
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "lazy", "mason", "notify", "noice", "TelescopePrompt" },
      callback = function()
        vim.b.miniindentscope_disable = true
        vim.b.minimove_disable = true
      end,
    })

    -- Disable mini.splitjoin in certain filetypes to avoid conflict
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "javascript", "javascriptreact", "typescript", "typescriptreact", "json", "html", "css" },
      callback = function()
        vim.b.minisplitjoin_disable = true
      end,
    })
  end,
}
