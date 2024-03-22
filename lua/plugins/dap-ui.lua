local M = {
  'rcarriga/nvim-dap-ui',
  event = 'VeryLazy',
  dependencies = {
    'mfussenegger/nvim-dap',
    'nvim-neotest/nvim-nio',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'
    dapui.setup()
    dap.listeners.after.event_initialized['dapui_config'] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated['dapui_config'] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited['dapui_config'] = function()
      dapui.close()
    end

    vim.keymap.set('n', '<F5>', dap.continue, { desc = 'start/continue' })
    vim.keymap.set('n', '<F1>', dap.step_into, { desc = 'step into' })
    vim.keymap.set('n', '<F2>', dap.step_over, { desc = 'step over' })
    vim.keymap.set('n', '<F3>', dap.step_out, { desc = 'step out' })
    vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = 'breakpoint' })
    vim.keymap.set('n', '<leader>dB', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'breakpoint w/ condition' })
    vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'last dap result' })
  end,
}

return M
