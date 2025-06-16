return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      --UI enhancements
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",

      --JavaScript/TypeScript debugging
      "mxsdev/nvim-dap-vscode-js",

      --Mason DAP integration
      "jay-babu/mason-nvim-dap.nvim",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      local mason_dap = require("mason-nvim-dap")

      -- Setup Mason for automatic installation of debuggers
      mason_dap.setup({
        ensure_installed = { "js-debug-adapter" },
        automatic_installation = true,
      })

      --Setup virtual text
      require("nvim-dap-virtual-text").setup({
        enabled = true,
        enabled_commands = true,
        highlight_changed_variables = true,
        highlight_new_as_changed = false,
        show_stop_reason = true,
        commented = false,
        only_first_definition = true,
        all_references = false,
        clear_on_continue = false,
        display_callback = function(variable, _, _, _, options)
          if options.virt_text_pos == "inline" then
            return " = " .. variable.value
          else
            return variable.name .. " = " .. variable.value
          end
        end,
      })

      --Setup DAP UI
      dapui.setup({
        icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
        mappings = {
          expand = { "<CR>", "<2-LeftMouse>" },
          open = "o",
          remove = "d",
          edit = "e",
          repl = "r",
          toggle = "t",
        },
        expand_lines = vim.fn.has("nvim-0.7") == 1,
        layouts = {
          {
            elements = {
              { id = "scopes", size = 0.25 },
              "breakpoints",
              "stacks",
              "watches",
            },
            size = 40,
            position = "left",
          },
          {
            elements = {
              "repl",
              "console",
            },
            size = 0.25,
            position = "bottom",
          },
        },
        controls = {
          enabled = true,
          element = "repl",
          icons = {
            pause = "",
            play = "",
            step_into = "",
            step_over = "",
            step_out = "",
            step_back = "",
            run_last = "↻",
            terminate = "□",
          },
        },
        floating = {
          max_height = nil,
          max_width = nil,
          border = "single",
          mappings = {
            close = { "q", "<Esc>" },
          },
        },
        windows = { indent = 1 },
        render = {
          max_type_length = nil,
          max_value_lines = 100,
        },
      })

      --Setup vscode-js-debug adapter
      require("dap-vscode-js").setup({
        debugger_path = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter",
        debugger_cmd = { "js-debug-adapter" },
        adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
      })

      --JavaScript/TypeScript configurations
      for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
        dap.configurations[language] = {
          --Debug Node.js applications
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch Node.js Program",
            program = "${file}",
            cwd = "${workspaceFolder}",
            sourceMaps = true,
            skipFiles = { "<node_internals>/**" },
            protocol = "inspector",
            console = "integratedTerminal",
            internalConsoleOptions = "neverOpen",
          },

          --Debug Node.js with TypeScript (ts-node)
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch TypeScript (ts-node)",
            program = "${file}",
            cwd = "${workspaceFolder}",
            runtimeExecutable = "ts-node",
            runtimeArgs = { "--transpile-only" },
            sourceMaps = true,
            skipFiles = { "<node_internals>/**" },
            console = "integratedTerminal",
            internalConsoleOptions = "neverOpen",
          },

          --Debug Express server
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch Express Server",
            program = "${workspaceFolder}/server/index.js", -- Adjust path as needed
            cwd = "${workspaceFolder}",
            env = {
              NODE_ENV = "development",
            },
            sourceMaps = true,
            skipFiles = { "<node_internals>/**" },
            console = "integratedTerminal",
            internalConsoleOptions = "neverOpen",
          },

          --Debug Next.js application
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch Next.js",
            program = "${workspaceFolder}/node_modules/.bin/next",
            args = { "dev" },
            cwd = "${workspaceFolder}",
            env = {
              NODE_OPTIONS = "--inspect=9230",
            },
            sourceMaps = true,
            skipFiles = { "<node_internals>/**" },
            console = "integratedTerminal",
            internalConsoleOptions = "neverOpen",
          },

          --Debug React app (Create React App)
          {
            type = "pwa-chrome",
            request = "launch",
            name = "Launch React App (Chrome)",
            url = "http://localhost:3000",
            webRoot = "${workspaceFolder}/src",
            sourceMaps = true,
            userDataDir = "${workspaceFolder}/.vscode/chrome-debug-profile",
          },

          --Attach to running Node.js process
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach to Node.js",
            processId = require("dap.utils").pick_process,
            cwd = "${workspaceFolder}",
            sourceMaps = true,
            skipFiles = { "<node_internals>/**" },
          },

          --Debug Jest tests
          {
            type = "pwa-node",
            request = "launch",
            name = "Debug Jest Tests",
            runtimeExecutable = "npm",
            runtimeArgs = { "run", "test", "--", "--runInBand" },
            rootPath = "${workspaceFolder}",
            cwd = "${workspaceFolder}",
            console = "integratedTerminal",
            internalConsoleOptions = "neverOpen",
            sourceMaps = true,
            skipFiles = { "<node_internals>/**" },
          },

          --Debug current Jest test file
          {
            type = "pwa-node",
            request = "launch",
            name = "Debug Current Test File",
            program = "${workspaceFolder}/node_modules/.bin/jest",
            args = { "${file}", "--runInBand" },
            cwd = "${workspaceFolder}",
            console = "integratedTerminal",
            internalConsoleOptions = "neverOpen",
            sourceMaps = true,
            skipFiles = { "<node_internals>/**" },
          },
        }
      end

      --MongoDB debugging
      dap.configurations.javascript = vim.list_extend(dap.configurations.javascript or {}, {
        {
          type = "pwa-node",
          request = "launch",
          name = "Debug MongoDB Script",
          program = "${file}",
          cwd = "${workspaceFolder}",
          env = {
            MONGODB_URI = "mongodb://localhost:27017/your-database", -- Adjust as needed
          },
          sourceMaps = true,
          skipFiles = { "<node_internals>/**" },
          console = "integratedTerminal",
          internalConsoleOptions = "neverOpen",
        },
      })

      --Auto-open/close DAP UI
      dap.listeners.after.event_initialized["dapui_config"] = dapui.open
      dap.listeners.before.event_terminated["dapui_config"] = dapui.close
      dap.listeners.before.event_exited["dapui_config"] = dapui.close

      vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "DiagnosticError" })
      vim.fn.sign_define("DapBreakpointCondition", { text = "🔶", texthl = "DiagnosticWarn" })
      vim.fn.sign_define("DapLogPoint", { text = "📝", texthl = "DiagnosticInfo" })
      vim.fn.sign_define("DapStopped", { text = "👉", texthl = "DiagnosticHint" })
      vim.fn.sign_define("DapBreakpointRejected", { text = "❌", texthl = "DiagnosticError" })
    end,

    keys = {
      --Function key mappings (more traditional debugging)
      {
        "<F5>",
        function()
          require("dap").continue()
        end,
        desc = "Continue",
      },
      {
        "<F10>",
        function()
          require("dap").step_over()
        end,
        desc = "Step Over",
      },
      {
        "<F11>",
        function()
          require("dap").step_into()
        end,
        desc = "Step Into",
      },
      {
        "<F12>",
        function()
          require("dap").step_out()
        end,
        desc = "Step Out",
      },

      --Leader key mappings
      {
        "<leader>b",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Toggle Breakpoint",
      },
      {
        "<leader>B",
        function()
          require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end,
        desc = "Conditional Breakpoint",
      },
      {
        "<leader>lp",
        function()
          require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
        end,
        desc = "Log Point",
      },
      {
        "<leader>dr",
        function()
          require("dap").repl.open()
        end,
        desc = "Open REPL",
      },
      {
        "<leader>dl",
        function()
          require("dap").run_last()
        end,
        desc = "Run Last",
      },
      {
        "<leader>do",
        function()
          require("dap").terminate()
        end,
        desc = "Terminate",
      },

      --Extended mappings
      {
        "<leader>dc",
        function()
          require("dap").continue()
        end,
        desc = "Continue",
      },
      {
        "<leader>dC",
        function()
          require("dap").run_to_cursor()
        end,
        desc = "Run to Cursor",
      },
      {
        "<leader>dd",
        function()
          require("dap").disconnect()
        end,
        desc = "Disconnect",
      },
      {
        "<leader>dg",
        function()
          require("dap").session()
        end,
        desc = "Get Session",
      },
      {
        "<leader>di",
        function()
          require("dap").step_into()
        end,
        desc = "Step Into",
      },
      {
        "<leader>dp",
        function()
          require("dap").pause()
        end,
        desc = "Pause",
      },
      {
        "<leader>ds",
        function()
          require("dap").session()
        end,
        desc = "Session",
      },
      {
        "<leader>dt",
        function()
          require("dap").terminate()
        end,
        desc = "Terminate",
      },

      -- DAP UI
      {
        "<leader>dw",
        function()
          require("dapui").toggle()
        end,
        desc = "Toggle DAP UI",
      },
      {
        "<leader>de",
        function()
          require("dapui").eval()
        end,
        desc = "Eval",
        mode = { "n", "v" },
      },

      --Additional mappings
      {
        "<leader>dL",
        function()
          require("dap").list_breakpoints()
        end,
        desc = "List Breakpoints",
      },
      {
        "<leader>dk",
        function()
          require("dap").up()
        end,
        desc = "Up",
      },
      {
        "<leader>dj",
        function()
          require("dap").down()
        end,
        desc = "Down",
      },
    },
  },
}
