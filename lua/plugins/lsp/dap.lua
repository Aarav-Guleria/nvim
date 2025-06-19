return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
      "mxsdev/nvim-dap-vscode-js",
      "jay-babu/mason-nvim-dap.nvim",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      local mason_dap = require("mason-nvim-dap")

      mason_dap.setup({
        ensure_installed = {
          "js-debug-adapter",
        },
        automatic_installation = true,
        handlers = {},
      })

      require("nvim-dap-virtual-text").setup({
        enabled = true,
        enabled_commands = true,
        highlight_changed_variables = true,
        show_stop_reason = true,
        virt_text_pos = vim.fn.has("nvim-0.10") == 1 and "inline" or "eol",
        display_callback = function(variable, _, _, _, options)
          local value = variable.value:gsub("%s+", " ")
          return options.virt_text_pos == "inline" and (" = " .. value) or (variable.name .. " = " .. value)
        end,
      })

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
        layouts = {
          {
            elements = {
              { id = "scopes", size = 0.3 },
              { id = "breakpoints", size = 0.2 },
              { id = "stacks", size = 0.25 },
              { id = "watches", size = 0.25 },
            },
            size = 40,
            position = "left",
          },
          {
            elements = {
              { id = "repl", size = 0.6 },
              { id = "console", size = 0.4 },
            },
            size = 0.25,
            position = "bottom",
          },
        },
        floating = {
          border = "single",
          mappings = { close = { "q", "<Esc>" } },
        },
        render = {
          max_value_lines = 100,
        },
      })

      require("dap-vscode-js").setup({
        node_path = "node",
        debugger_path = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter",
        debugger_cmd = { "js-debug-adapter" },
        adapters = {
          "chrome",
          "pwa-chrome",
          "pwa-msedge",
          "node-terminal",
          "pwa-extensionHost",
          "pwa-node",
        },
      })

      -- Optimized webdev-focused configurations
      local js_languages = { "typescript", "javascript", "typescriptreact", "javascriptreact" }
      for _, language in ipairs(js_languages) do
        dap.configurations[language] = {
          -- Node.js debugging
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch Node.js Program",
            program = "${file}",
            cwd = "${workspaceFolder}",
            sourceMaps = true,
            skipFiles = { "<node_internals>/**" },
            console = "integratedTerminal",
            internalConsoleOptions = "neverOpen",
          },
          -- TypeScript with ts-node
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch TypeScript (ts-node)",
            program = "${file}",
            cwd = "${workspaceFolder}",
            runtimeExecutable = "npx",
            runtimeArgs = { "ts-node", "--transpile-only" },
            sourceMaps = true,
            console = "integratedTerminal",
            internalConsoleOptions = "neverOpen",
          },
          -- Next.js debugging
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch Next.js Dev",
            program = "${workspaceFolder}/node_modules/.bin/next",
            args = { "dev" },
            cwd = "${workspaceFolder}",
            env = { NODE_OPTIONS = "--inspect" },
            sourceMaps = true,
            console = "integratedTerminal",
            internalConsoleOptions = "neverOpen",
          },
          -- Vite debugging
          {
            type = "pwa-chrome",
            request = "launch",
            name = "Launch Vite Dev Server",
            url = "http://localhost:5173",
            webRoot = "${workspaceFolder}/src",
            userDataDir = "${workspaceFolder}/.vscode/chrome-debug-profile",
          },
          -- React debugging
          {
            type = "pwa-chrome",
            request = "launch",
            name = "Launch React App (Chrome)",
            url = "http://localhost:3000",
            webRoot = "${workspaceFolder}/src",
            userDataDir = "${workspaceFolder}/.vscode/chrome-debug-profile",
          },
          -- Attach to running Node.js process
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach to Node.js",
            processId = require("dap.utils").pick_process,
            cwd = "${workspaceFolder}",
            sourceMaps = true,
            skipFiles = { "<node_internals>/**" },
          },
          -- Biome-friendly test debugging (using native test runners)
          {
            type = "pwa-node",
            request = "launch",
            name = "Debug Jest Tests",
            runtimeExecutable = "npm",
            runtimeArgs = { "run", "test", "--", "--runInBand" },
            cwd = "${workspaceFolder}",
            sourceMaps = true,
            console = "integratedTerminal",
            internalConsoleOptions = "neverOpen",
          },
          -- Vitest debugging (modern alternative to Jest)
          {
            type = "pwa-node",
            request = "launch",
            name = "Debug Vitest Tests",
            runtimeExecutable = "npx",
            runtimeArgs = { "vitest", "run", "${file}" },
            cwd = "${workspaceFolder}",
            sourceMaps = true,
            console = "integratedTerminal",
            internalConsoleOptions = "neverOpen",
          },
        }
      end

      -- Event listeners
      dap.listeners.before.attach.dapui_config = dapui.open
      dap.listeners.before.launch.dapui_config = dapui.open
      dap.listeners.before.event_terminated.dapui_config = dapui.close
      dap.listeners.before.event_exited.dapui_config = dapui.close

      -- Modern sign definitions
      vim.fn.sign_define(
        "DapBreakpoint",
        { text = "🛑", texthl = "DiagnosticError", linehl = "DapBreakpointLine", numhl = "DapBreakpointNumber" }
      )
      vim.fn.sign_define("DapStopped", { text = "👉", texthl = "DiagnosticHint" })
      vim.fn.sign_define("DapLogPoint", { text = "📝", texthl = "DiagnosticInfo" })
      vim.fn.sign_define("DapBreakpointCondition", { text = "🔶", texthl = "DiagnosticWarn" })
      vim.fn.sign_define("DapBreakpointRejected", { text = "❌", texthl = "DiagnosticError" })
    end,

    keys = {
      -- Function keys for common debugging actions
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

      -- Breakpoint management
      {
        "<leader>db",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Toggle Breakpoint",
      },
      {
        "<leader>dB",
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

      -- Session control
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
        "<leader>dt",
        function()
          require("dap").terminate()
        end,
        desc = "Terminate",
      },
      {
        "<leader>dl",
        function()
          require("dap").run_last()
        end,
        desc = "Run Last",
      },

      -- Stepping
      {
        "<leader>di",
        function()
          require("dap").step_into()
        end,
        desc = "Step Into",
      },
      {
        "<leader>do",
        function()
          require("dap").step_over()
        end,
        desc = "Step Over",
      },
      {
        "<leader>dO",
        function()
          require("dap").step_out()
        end,
        desc = "Step Out",
      },

      -- UI toggles
      {
        "<leader>dw",
        function()
          require("dapui").toggle()
        end,
        desc = "Toggle DAP UI",
      },
      {
        "<leader>dr",
        function()
          require("dap").repl.toggle()
        end,
        desc = "Toggle REPL",
      },
      {
        "<leader>de",
        function()
          require("dapui").eval()
        end,
        desc = "Eval",
        mode = { "n", "v" },
      },

      -- Advanced features
      {
        "<leader>dh",
        function()
          require("dap.ui.widgets").hover()
        end,
        desc = "Hover Variables",
      },
      {
        "<leader>dS",
        function()
          local widgets = require("dap.ui.widgets")
          widgets.centered_float(widgets.scopes)
        end,
        desc = "Scopes",
      },
    },
  },
}
