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
    --Core Editing Enhancements
    require("mini.ai").setup()
    require("mini.comment").setup()
    require("mini.diff").setup()
    require("mini.operators").setup()
    require("mini.splitjoin").setup()
    require("mini.trailspace").setup()
    require("mini.surround").setup()
    require("mini.pairs").setup()

    -- 🧱 Structural/Visual Enhancements
    require("mini.align").setup()
    require("mini.move").setup()
    require("mini.bracketed").setup()

    -- 🎞️ Animate UI (except for popups like Noice)
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

    -- 🔍 Dynamic indent guides with active scope highlight only
    require("mini.indentscope").setup({
      symbol = "│",
      options = { try_as_border = true },
      draw = {
        delay = 0,
        animation = require("mini.indentscope").gen_animation.none(),
      },
    })

    -- Disable indentscope in popup-type UIs
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "lazy", "mason", "notify", "noice", "TelescopePrompt" },
      callback = function()
        vim.b.miniindentscope_disable = true
      end,
    })

    -- 🧠 Smart keybinding hints
    require("mini.clue").setup({
      triggers = {
        { mode = "n", keys = "<Leader>" },
        { mode = "x", keys = "<Leader>" },
        { mode = "n", keys = "g" },
        { mode = "n", keys = "'" },
        { mode = "n", keys = "`" },
        { mode = "x", keys = "g" },
        { mode = "i", keys = "<C-x>" },
        { mode = "c", keys = "<C-x>" },
      },
      clues = {
        require("mini.clue").gen_clues.builtin_completion(),
        require("mini.clue").gen_clues.g(),
        require("mini.clue").gen_clues.marks(),
        require("mini.clue").gen_clues.registers(),
        require("mini.clue").gen_clues.windows(),
        require("mini.clue").gen_clues.z(),
      },
      window = {
        config = {
          border = "rounded",
        },
      },
    })
  end,
}
