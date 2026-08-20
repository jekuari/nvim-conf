return {
  "rcarriga/nvim-dap-ui",
  dependencies = {
    "mfussenegger/nvim-dap",
    "nvim-neotest/nvim-nio",
    "mfussenegger/nvim-dap-python",
  },
  config = function()
    local dap, dapui, dap_python = require("dap"), require("dapui"), require("dap-python")
    
    dapui.setup()
    dap_python.setup("python")
    dap_python.test_runner = "pytest"

		local venv = os.getenv("VIRTUAL_ENV")
		local python_path = venv and (venv .. "/bin/python") or "python"

		dap.adapters.python = {
			type = "executable",
			command = python_path,
			args = { "-m", "debugpy.adapter" },
		}
    -- Node/JS adapter (requires `:MasonInstall js-debug-adapter`)
    dap.adapters["pwa-node"] = {
      type = "server",
      host = "127.0.0.1",
      port = "${port}",
      executable = {
        command = "js-debug-adapter",
        -- Pass the host explicitly: with port only, js-debug binds IPv6 [::1],
        -- but `host` below is IPv4 127.0.0.1 -> ECONNREFUSED. Keep them in sync.
        args = { "${port}", "127.0.0.1" },
      },
    }

    -- UI Auto-open/close logic
    dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
    dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
    dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

    -- Python specific adapter
    dap.adapters.python = {
      type = "executable",
      command = os.getenv("VIRTUAL_ENV") and (os.getenv("VIRTUAL_ENV") .. "/bin/python") or "python",
      args = { "-m", "debugpy.adapter" },
    }

    ---------------------------------------------------------------------------
    -- SMART TEST RUNNER DISPATCHER
    ---------------------------------------------------------------------------
    local function smart_test()
      local ft = vim.bo.filetype
      if ft == "python" then
        dap_python.test_method()
      elseif ft == "java" then
        require('jdtls').test_nearest_method()
      else
        vim.notify("No test runner configured for filetype: " .. ft, vim.log.levels.WARN)
      end
    end

    local function smart_test_class()
      local ft = vim.bo.filetype
      if ft == "java" then
        require('jdtls').test_class()
      else
        vim.notify("Test class runner only configured for Java", vim.log.levels.WARN)
      end
    end

    ---------------------------------------------------------------------------
    -- GLOBAL KEYMAPS
    ---------------------------------------------------------------------------
    local set = vim.keymap.set
    set("n", "<leader>dar", dap.continue, { desc = "DAP: Continue/Run" })
    set("n", "<leader>dab", dap.toggle_breakpoint, { desc = "DAP: Toggle Breakpoint" })
    set("n", "<leader>dasi", dap.step_into, { desc = "DAP: Step Into" })
    set("n", "<leader>daso", dap.step_over, { desc = "DAP: Step Over" })
    set("n", "<leader>dax", dap.terminate, { desc = "DAP: Terminate" })
    set("n", "<leader>dat", dapui.toggle, { desc = "DAP: Toggle UI" })
    set("n", "<leader>dal", dap.run_last, { desc = "DAP: Run Last" })

    -- THE DYNAMIC MAPPINGS
    set("n", "<leader>daTr", smart_test, { desc = "DAP: Run Nearest Test (Smart)" })
    set("n", "<leader>daTc", smart_test_class, { desc = "DAP: Run Test Class (Java)" })

    -- Attach to remote JVM (e.g. mvn -Dmaven.surefire.debug, port 5005)
    set("n", "<leader>daA", function()
      dap.run({
        type = "java",
        request = "attach",
        name = "Attach to remote JVM (5005)",
        hostName = "localhost",
        port = 5005,
        console = "integratedTerminal",
      })
    end, { desc = "DAP: Attach to remote JVM (5005)" })

    -- Attach to a running Node process on the inspector port (node --inspect, 9229)
    set("n", "<leader>dan", function()
      dap.run({
        type = "pwa-node",
        request = "attach",
        name = "Attach to Node (9229)",
        address = "127.0.0.1",
        port = 9229,
        cwd = "${workspaceFolder}",
      })
    end, { desc = "DAP: Attach to Node (9229)" })

    -- Java Specific Main Discovery
    set("n", "<leader>daJ", function()
      if vim.bo.filetype == "java" then
        require('jdtls.dap').setup_dap_main_class_configs()
        dap.continue()
      end
    end, { desc = "Java: Discover Main & Debug" })
  end,
}
