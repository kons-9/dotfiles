local spec = {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'theHamsta/nvim-dap-virtual-text',
      'rcarriga/nvim-dap-ui',
      -- 'mfussenegger/nvim-dap-python',
    },
    config = function()
      require("dapui").setup({
        icons = {
          expanded = "▾",
          collapsed = "▸",
        },
        layouts = {
          {
            elements = {
              { id = "watches", size = 0.20 },
              { id = "stacks", size = 0.20 },
              { id = "breakpoints", size = 0.20 },
              { id = "scopes", size = 0.40 },
            },
            size = 64,
            position = "right",
          },
          {
            elements = {
              "repl",
              "console",
            },
            size = 0.20,
            position = "bottom",
          },
        },
      })
      utils.keymap('n', '<Leader>dt', function()
        require("dapui").toggle()
      end, { desc = 'Toggle DAP UI' })
      utils.keymap({'n', 'v'}, '<Leader>dh', function()
        require('dapui').eval()
      end, { desc = 'Evaluate' })

      utils.keymap('n', '<leader>dc', function() require("dap").continue() end, { desc = 'Continue' })
      utils.keymap('n', '<leader>do', function() require("dap").step_over() end, { desc = 'Step over' })
      utils.keymap('n', '<leader>di', function() require("dap").step_into() end, { desc = 'Step into' })
      utils.keymap('n', '<leader>ds', function() require("dap").step_out() end, { desc = 'Step out' })
      utils.keymap('n', '<Leader>db', function() require("dap").toggle_breakpoint() end, { desc = 'Toggle breakpoint' })
      utils.keymap('n', '<Leader>dB', function() require("dap").set_breakpoint() end, { desc = 'Set breakpoint' })
      utils.keymap('n', '<Leader>dp', function() require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end, { desc = 'log'})
      utils.keymap('n', '<Leader>dr', function() require("dap").repl.open() end, { desc = 'Open REPL' })
      utils.keymap('n', '<Leader>dl', function() require("dap").run_last() end, { desc = 'Run last' })
      utils.keymap('n', '<Leader>de', function() require("dap").terminate() end, { desc = 'Terminate' })

      -- python
      local dap = require('dap')

      dap.adapters.python = function(cb, config) 
        if config.request == 'attach' then
          local port = (config.connect or config).port
          local host = (config.connect or config).host or '127.0.0.1'
          cb({
            type = 'server',
            host = host,
            port = assert(port, '`connect.port` is required for a python `attach` configuration'),
            options = {
              source_filetype = 'python',
            },
          })
        else
          cb({
            type = 'executable',
            command = vim.fn.exepath('python3'),
            args = {'-m', 'debugpy.adapter'},
            options = {
              source_filetype = 'python',
            },
          })
        end
      end

      dap.configurations.python = {
        {
          type = 'python';
          request = 'launch';
          name = 'Launch file';
          program = '${file}';
          justMyCode = false;
          pythonPath = function()
            local cwd = vim.fn.getcwd()
            if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
              return cwd .. '/venv/bin/python'
            elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
              return cwd .. '/.venv/bin/python'
            elseif os.getenv('VIRTUAL_ENV') then
              return os.getenv('VIRTUAL_ENV') .. '/bin/python'
            else
              return '/usr/local/bin/python3.11'
            end
          end;
        }
      }
    end,
  }
}
return spec

