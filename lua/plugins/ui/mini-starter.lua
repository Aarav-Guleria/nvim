return {
  "echasnovski/mini.starter",
  event = "VimEnter",
  config = function()
    local starter = require("mini.starter")

    starter.setup({
      header = table.concat({
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                     ]],
        [[       ████ ██████           █████      ██                     ]],
        [[      ███████████             █████                             ]],
        [[      █████████ ███████████████████ ███   ███████████   ]],
        [[     █████████  ███    █████████████ █████ ██████████████   ]],
        [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
        [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
        [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                       ]],
      }, "\n"),
      items = {
        starter.sections.recent_files(5, true),
        starter.sections.builtin_actions(),
        starter.sections.sessions(),
      },
      footer = "⚡ Neovim loaded.",
      content_hooks = {
        starter.gen_hook.adding_bullet("» "),
        starter.gen_hook.aligning("center", "center"),
      },
    })
  end,
}
