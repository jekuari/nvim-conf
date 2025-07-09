return { 
  "rcarriga/nvim-dap-ui", 
  dependencies = {
    "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio", "mfussenegger/nvim-dap-python"
  },
  config = function()
    local dap, dapui, dap_python = require("dap"), require("dapui"), require('dap-python') 
    dapui.setup()
    dap_python.setup("python")
    dap_python.test_runner = 'pytest'

    dap.adapters.python = {
      type = 'executable';
      command = os.getenv("VIRTUAL_ENV") .. "/bin/python";
      args = { '-m', 'debugpy.adapter' };
    }
    

    vim.keymap.set(
      "n",
      "<leader>dal",
      dap.run_last,
      {desc = "Run Last"}
    )


    vim.keymap.set(
      "n",
      "<leader>dao",
      dapui.open,
      {desc = "Open debugger"}
    )

    vim.keymap.set(
      "n",
      "<leader>dac",
      dapui.close,
      {desc = "Close debugger"}
    )

    vim.keymap.set(
      "n",
      "<leader>dat",
      dapui.toggle,
      {desc = "Toggle debugger"}
    )

    vim.keymap.set(
      "n",
      "<leader>dar",
      dap.continue,
      {desc = "Run / Continue"}
    )

    vim.keymap.set(
      "n",
      "<leader>daR",
      function(buff)
        dap.run(
          {
              type = 'debugpy';
              request = 'launch';
              name = "file";
              program = vim.fn.getcwd() .. "/main.py";
              pythonPath = 'python';
              console = "integratedTerminal";
              cwd = vim.fn.getcwd();
          }
        )
      end,
      {desc = "Run (New)"}
    )

    vim.keymap.set(
      "n",
      "<leader>dasi",
      dap.step_into,
      {desc = "Step into"}
    )

    vim.keymap.set(
      "n",
      "<leader>daso",
      dap.step_over,
      {desc = "Step over"}
    )

    vim.keymap.set(
      "n",
      "<leader>dab",
      dap.toggle_breakpoint,
      {desc = "Toggle breakpoint"}
    )

    vim.keymap.set(
      "n",
      "<leader>daTr",
      dap_python.test_method,
      {desc = "Run test under cursor"}
    )

    vim.keymap.set(
      "n",
      "<leader>daTt",
      function()
        dap_python.test_method({ config = { justMyCode = false } }) 
      end,
      {desc = "Run test under cursor justMyCode False"}
    )

    vim.keymap.set(
      "n",
      "<leader>dax",
      dap.terminate,
      {desc = "Terminate"}
    )
  end
}
