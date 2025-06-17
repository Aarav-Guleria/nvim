return {
  {
    "rmagatti/auto-session",
    lazy = false, -- Load on startup to handle session restoration
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      local auto_session = require("auto-session")

      auto_session.setup({

        log_level = "error",
        auto_restore = false,
        auto_restore_last_session = false,
        root_dir = vim.fn.stdpath("data") .. "/sessions/",
        enabled = true,
        auto_save = false,

        suppressed_dirs = {
          "~/",
          "~/Downloads",
          "/tmp",
        },

        -- Session lens (Telescope integration)
        session_lens = {
          theme_conf = { border = true },
          previewer = false,
          prompt_title = "Sessions",
          mappings = {
            delete_session = { "i", "<C-d>" },
            alternate_session = { "i", "<C-s>" },
          },
        },

        -- Hooks for custom behavior
        pre_save_cmds = {
          "NvimTreeClose",
          "Neotree close",
          "cclose",
          "lclose",
        },
        save_extra_cmds = {
          function()
            return [[
              " Custom session data
              let g:session_cwd = getcwd()
            ]]
          end,
        },
        post_restore_cmds = {
          function()
            if vim.g.session_cwd then
              vim.cmd("cd " .. vim.g.session_cwd)
            end
            -- vim.cmd("NvimTreeOpen")
          end,
        },
      })

      --custom functions and user commands
      local function session_save()
        local session_name = vim.fn.input("Session name: ")
        if session_name ~= "" then
          require("auto-session").SaveSession(session_name)
          vim.notify("Session '" .. session_name .. "' saved!", vim.log.levels.INFO)
        end
      end

      local function session_restore()
        require("auto-session.session-lens").search_session()
      end

      local function session_delete()
        local sessions_dir = require("auto-session.lib").get_root_dir()
        local sessions = {}
        local handle = vim.loop.fs_scandir(sessions_dir)
        if handle then
          while true do
            local name, type = vim.loop.fs_scandir_next(handle)
            if not name then
              break
            end
            if type == "file" and name:match("%.vim$") then
              table.insert(sessions, name:gsub("%.vim$", ""))
            end
          end
        end

        if #sessions == 0 then
          vim.notify("No sessions found!", vim.log.levels.WARN)
          return
        end

        vim.ui.select(sessions, {
          prompt = "Delete session:",
          format_item = function(item)
            return item
          end,
        }, function(choice)
          if choice then
            local session_file = sessions_dir .. choice .. ".vim"
            local success = os.remove(session_file)
            if success then
              vim.notify("Session '" .. choice .. "' deleted!", vim.log.levels.INFO)
            else
              vim.notify("Failed to delete session '" .. choice .. "'", vim.log.levels.ERROR)
            end
          end
        end)
      end

      local function session_list()
        require("auto-session.session-lens").search_session()
      end

      local function session_save_current()
        local cwd = vim.fn.getcwd()
        local session_name = vim.fn.fnamemodify(cwd, ":t")
        require("auto-session").SaveSession(session_name)
        vim.notify("Session '" .. session_name .. "' saved!", vim.log.levels.INFO)
      end

      vim.api.nvim_create_user_command("SessionSave", session_save, { desc = "Save session with custom name" })
      vim.api.nvim_create_user_command("SessionRestore", session_restore, { desc = "Restore session from list" })
      vim.api.nvim_create_user_command("SessionDelete", session_delete, { desc = "Delete session from list" })
      vim.api.nvim_create_user_command("SessionList", session_list, { desc = "List all sessions" })
      vim.api.nvim_create_user_command(
        "SessionSaveCurrent",
        session_save_current,
        { desc = "Save current directory as session" }
      )

      _G.session_manager = {
        save = session_save,
        restore = session_restore,
        delete = session_delete,
        list = session_list,
        save_current = session_save_current,
      }
    end,

    keys = {
      {
        "<leader>ss",
        function()
          _G.session_manager.save()
        end,
        desc = "Save Session",
      },
      {
        "<leader>sr",
        function()
          _G.session_manager.restore()
        end,
        desc = "Restore Session",
      },
      {
        "<leader>sl",
        function()
          _G.session_manager.list()
        end,
        desc = "List Sessions",
      },
      {
        "<leader>sd",
        function()
          _G.session_manager.delete()
        end,
        desc = "Delete Session",
      },
      {
        "<leader>sc",
        function()
          _G.session_manager.save_current()
        end,
        desc = "Save Current Session",
      },
      { "<leader>fs", "<cmd>Telescope session-lens search_session<cr>", desc = "Find Sessions" },
    },
  },

  -- persistence.nvim config
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {
      dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"),
      options = { "buffers", "curdir", "tabpages", "winsize" },
    },
    keys = {
      {
        "<leader>sp",
        function()
          require("persistence").load()
        end,
        desc = "Restore Session (Persistence)",
      },
      {
        "<leader>sP",
        function()
          require("persistence").load({ last = true })
        end,
        desc = "Restore Last Session",
      },
      {
        "<leader>sq",
        function()
          require("persistence").stop()
        end,
        desc = "Don't Save Current Session",
      },
    },
  },
}
