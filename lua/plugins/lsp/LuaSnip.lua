return {
  "L3MON4D3/LuaSnip",
  version = "v2.*",
  build = "make install_jsregexp",
  event = "InsertEnter",
  config = function()
    local luasnip = require("luasnip")
    local types = require("luasnip.util.types")

    luasnip.config.set_config({
      history = true,
      updateevents = "TextChanged,TextChangedI",
      enable_autosnippets = true,
      store_selection_keys = "<Tab>",
      ext_opts = {
        [types.insertNode] = {
          active = { hl_group = "LuasnipInsertNodeActive" },
          passive = { hl_group = "LuasnipInsertNodePassive" },
          snippet_passive = { hl_group = "LuasnipSnippetPassive" },
        },
        [types.choiceNode] = {
          active = { hl_group = "LuasnipChoiceNodeActive" },
        },
      },
    })

    require("luasnip.loaders.from_vscode").lazy_load()
    require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets" })

    vim.keymap.set({ "i", "s" }, "<C-k>", function()
      if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      end
    end, { silent = true, desc = "LuaSnip: Expand or jump forward" })

    vim.keymap.set({ "i", "s" }, "<C-j>", function()
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      end
    end, { silent = true, desc = "LuaSnip: Jump backward" })

    vim.keymap.set({ "i", "s" }, "<C-l>", function()
      if luasnip.choice_active() then
        luasnip.change_choice(1)
      end
    end, { silent = true, desc = "LuaSnip: Change choice node" })

    vim.api.nvim_create_autocmd("ModeChanged", {
      pattern = "*",
      callback = function()
        local cur = luasnip.session.current_nodes[vim.api.nvim_get_current_buf()]
        if cur and not luasnip.session.jump_active then
          luasnip.unlink_current()
        end
      end,
    })

    vim.api.nvim_create_user_command("LuaSnipEdit", function()
      require("luasnip.loaders").edit_snippet_files()
    end, { desc = "Edit LuaSnip snippet files" })
  end,
}
