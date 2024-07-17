local M = {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  keys = {
    { '<leader>D', group = '[D]ad-bod' },
    { '<leader>D_', hidden = true },
    { '<leader>b', group = '[b]uffer' },
    { '<leader>b_', hidden = true },
    { '<leader>c', group = '[c]ode' },
    { '<leader>c_', hidden = true },
    { '<leader>ch', group = 'copilot c[h]at' },
    { '<leader>ch_', hidden = true },
    { '<leader>d', group = '[d]iagnostic/debug' },
    { '<leader>d_', hidden = true },
    { '<leader>f', group = '[f]ind' },
    { '<leader>fC', group = '[C]opilot Chat' },
    { '<leader>fC_', hidden = true },
    { '<leader>f_', hidden = true },
    { '<leader>g', group = '[g]it' },
    { '<leader>g_', hidden = true },
    { '<leader>h', group = '[h]arpoon' },
    { '<leader>h_', hidden = true },
    { '<leader>n', group = '[n]eotest' },
    { '<leader>n_', hidden = true },
    { '<leader>r', group = '[r]un' },
    { '<leader>r_', hidden = true },
    { '<leader>t', group = '[t]ab/term/todo' },
    { '<leader>t_', hidden = true },
    { '<leader>tr', group = '[r]un' },
    { '<leader>tr_', hidden = true },
    { '<leader>w', group = '[w]indow' },
    { '<leader>w_', hidden = true },
    { '<leader>y', group = '[y]taudio' },
    { '<leader>y_', hidden = true },
    { '<leader>z', group = '[z]en mode' },
    { '<leader>z_', hidden = true },
  },
}

return M
